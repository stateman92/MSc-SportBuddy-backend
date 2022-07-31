//
//  AuthorizationService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

/// A common abstract class for the service that is capable of authorize the incoming requests.
class AuthorizationService: Initable, AutoMockable {
    /// Initialize the object.
    required init() { }

    /// Authenticate the incoming request.
    /// - Parameter token: the authentication (bearer) token.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    /// - Note: This method must be overridden.
    func auth(token: String, req: Request) -> EventLoopFuture<Void> {
        fatalError("AuthorizationService.auth(token:request) must be overridden!")
    }
}

// MARK: - BearerAuthenticator

extension AuthorizationService: BearerAuthenticator {
    /// Authenticate the incoming request.
    /// - Parameter bearer: the authentication object.
    /// - Parameter request: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func authenticate(bearer: BearerAuthorization, for request: Request) -> EventLoopFuture<Void> {
        auth(token: bearer.token, req: request)
    }
}

// MARK: - AuthenticationMiddleware

extension AuthorizationService: AuthenticationMiddleware {
    /// Type of the auth. This type of object will be provided to the controllers.
    /// - Returns: The type of the auth.
    func authType() -> User.Type {
        User.self
    }
}
