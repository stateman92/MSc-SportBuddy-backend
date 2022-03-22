//
//  UserController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class UserController {
    @LazyInjected private var authenticationService: AuthenticationServiceProtocol
    @LazyInjected private var emailService: EmailServiceProtocol
}

extension UserController: UserControllerProtocol {
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
                let user = User(id: UUID(), name: name, email: email, password: hashedPassword, profileImage: .empty, bio: .empty, token: token, chats: .empty, groups: .empty)
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
}
