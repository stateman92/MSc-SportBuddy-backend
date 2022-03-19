//
//  AuthorizationService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class AuthorizationService: AuthorizationServiceProtocol {
    /// Authenticate the incoming request.
    /// - Parameter token: the authentication (bearer) token.
    /// - Parameter request: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    /// - Note: This method must be overridden.
    override func auth(token: String, request: Request) -> EventLoopFuture<Void> {
        User.queryAll(on: request) { users in
            if let user = users.first(where: { $0.token?.token.uuidString == token }),
               user.token?.isValid(validityDuration: Constants.tokenValidityInterval) == true {
                request.auth.login(user)
                user.token?.refresh()
                return user.update(on: request.db)
            }
            return request.eventLoop.makeSucceededFuture(())
        }
    }
}
