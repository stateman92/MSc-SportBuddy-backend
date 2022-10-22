//
//  UserControllerImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class UserControllerImpl {
    // Properties

    @LazyInjected private var authenticationService: AuthenticationService
    @LazyInjected private var emailService: EmailService
}

// MARK: UserController

extension UserControllerImpl: UserController {
    func registerPost(with req: Request, name: String, email: String, password: String) throws -> EventLoopFuture<registerPostResponse> {
        guard let hashedPassword = authenticationService.hash(password: password),
              authenticationService.isValid(email: email) else { return req.eventLoop.future(.http400) }
        return req
            .repositories
            .users
            .queryAll()
            .flatMap {
                if $0.contains(where: { $0.email == email }) {
                    return req.eventLoop.future(.http400)
                }
                let token = Token()
                let user = User(id: UUID(), name: name, email: email, password: hashedPassword, profileImage: .init(), bio: .init(), isAdmin: false, token: token, chats: .init())
                return req.repositories.users.create(user, transformTo: .http200(UserResponseDTO(token: token.token, user: user.dto)))
            }
    }

    func loginPost(with req: Request, email: String, password: String) throws -> EventLoopFuture<loginPostResponse> {
        req
            .repositories
            .users
            .queryAll()
            .flatMap {
                if let user = $0.first(where: { $0.email == email }),
                   self.authenticationService.isValid(password: password, hashedPassword: user.password) {
                    if var token = user.token, token.isValid(validityDuration: Constants.tokenValidityInterval) {
                        token.refresh()
                        user.token = token
                        return req.repositories.users.update(user, transformTo: .http200(.init(token: token.token, user: user.dto)))
                    } else {
                        let token = Token()
                        user.token = token
                        return req.repositories.users.update(user, transformTo: .http200(.init(token: token.token, user: user.dto)))
                    }
                }
                return req.eventLoop.future(.http400)
            }
    }

    func adminLoginPost(with req: Request, email: String, password: String) throws -> EventLoopFuture<adminLoginPostResponse> {
        req
            .repositories
            .users
            .queryAll()
            .flatMap {
                if let user = $0.first(where: { $0.email == email && $0.isAdmin }),
                   self.authenticationService.isValid(password: password, hashedPassword: user.password) {
                    if var token = user.token, token.isValid(validityDuration: Constants.tokenValidityInterval) {
                        token.refresh()
                        user.token = token
                        return req.repositories.users.update(user, transformTo: .http200(.init(token: token.token, user: user.dto)))
                    } else {
                        let token = Token()
                        user.token = token
                        return req.repositories.users.update(user, transformTo: .http200(.init(token: token.token, user: user.dto)))
                    }
                }
                return req.eventLoop.future(.http400)
            }
    }

    func forgotPasswordPost(with req: Request, email: String) throws -> EventLoopFuture<forgotPasswordPostResponse> {
        try emailService
            .sendPasswordRecoveryEmail(to: email, on: req)
            .transform(to: .http200)
    }

    func logoutPost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<logoutPostResponse> {
        req
            .repositories
            .users
            .queryAll()
            .flatMap {
                if let user = $0.first(where: { $0.email == user.email }),
                   let token = user.token,
                   token.isValid(validityDuration: Constants.tokenValidityInterval) {
                    user.token = nil
                    return req.repositories.users.update(user, transformTo: .http200)
                }
                return req.eventLoop.future(.http400)
            }
    }

    func imagePost(with req: Request, asAuthenticated user: User, body: String?) throws -> EventLoopFuture<imagePostResponse> {
        req
            .repositories
            .users
            .queryAll()
            .flatMap {
                if let user = $0.first(where: { $0.email == user.email }) {
                    user.profileImage = body ?? .init()
                    return req.repositories.users.update(user, transformTo: .http200(user.dto))
                }
                return req.eventLoop.future(.http400)
            }
    }

    func userImageGet(with req: Request, asAuthenticated user: User, chatId: String) throws -> EventLoopFuture<userImageGetResponse> {
        req
            .repositories
            .chats
            .find(.init(uuidString: chatId))
            .unwrapOrAbort()
            .map { $0.users.first { $0 != user.id } }
            .flatMap { userId in
                req
                    .repositories
                    .users
                    .find(userId)
                    .unwrapOrAbort()
                    .map(\.profileImage)
                    .map { .http200($0) }
            }
    }
}
