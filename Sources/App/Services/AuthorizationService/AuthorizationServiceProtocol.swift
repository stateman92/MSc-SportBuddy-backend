//
//  AuthorizationServiceProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

class AuthorizationServiceProtocol: Initable {
    required init() { }

    func auth(token: String, request: Request) -> EventLoopFuture<Void> {
        fatalError("AuthorizationServiceProtocol.auth(token:request) must be overridden!")
    }
}

extension AuthorizationServiceProtocol: BearerAuthenticator {
    func authenticate(bearer: BearerAuthorization, for request: Request) -> EventLoopFuture<Void> {
        auth(token: bearer.token, request: request)
    }

    func authenticate(request: Request) -> EventLoopFuture<Void> {
        guard let token = request.headers.bearerAuthorization?.token else {
            return request.eventLoop.makeSucceededVoidFuture()
        }
        return auth(token: token, request: request)
    }
}

extension AuthorizationServiceProtocol: AuthenticationMiddleware {
    func authType() -> User.Type {
        User.self
    }
}
