//
//  AuthorizationService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class AuthorizationService: AuthorizationServiceProtocol {
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
