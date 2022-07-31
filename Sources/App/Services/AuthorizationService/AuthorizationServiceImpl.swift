//
//  AuthorizationServiceImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class AuthorizationServiceImpl: AuthorizationService {
    /// Authenticate the incoming request.
    /// - Parameter token: the authentication (bearer) token.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    /// - Note: This method must be overridden.
    override func auth(token: String, req: Request) -> EventLoopFuture<Void> {
        req
            .repositories
            .users
            .queryAll() { users in
            if let user = users.first(where: { $0.token?.token.uuidString == token }),
               user.token?.isValid(validityDuration: Constants.tokenValidityInterval) == true {
                req.auth.login(user)
                user.token?.refresh()
                return req.repositories.users.update(user)
            }
            return req.eventLoop.makeSucceededFuture(())
        }
    }
}
