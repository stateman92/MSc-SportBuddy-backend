//
//  AuthorizationService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

/// A protocol for authorizing the incoming requests.
protocol AuthorizationService: Initable, AutoMockable, BearerAuthenticator, AuthenticationMiddleware where AuthType == User {
    /// Authenticate the incoming request.
    /// - Parameter token: the authentication (bearer) token.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func auth(token: String, req: Request) -> EventLoopFuture<Void>
}

// MARK: - BearerAuthenticator

extension AuthorizationService {
    /// Authenticate the incoming request.
    /// - Parameter bearer: the authentication object.
    /// - Parameter request: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func authenticate(bearer: BearerAuthorization, for request: Request) -> EventLoopFuture<Void> {
        auth(token: bearer.token, req: request)
    }
}

// MARK: - AuthenticationMiddleware

extension AuthorizationService {
    /// Type of the auth. This type of object will be provided to the controllers.
    /// - Returns: The type of the auth.
    func authType() -> User.Type {
        User.self
    }
}
