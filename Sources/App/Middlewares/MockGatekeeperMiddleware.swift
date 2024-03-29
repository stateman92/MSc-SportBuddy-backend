//
//  MockGatekeeperMiddleware.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

/// A mock middleware that acts as a rate limiter.
final class MockGatekeeperMiddleware: Initable { }

// MARK: - Middleware

extension MockGatekeeperMiddleware: Middleware {
    /// Respond to the given request.
    /// - Parameter req: the request.
    /// - Parameter next: the next responder (maybe another middleware or the application).
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func respond(to req: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        next.respond(to: req)
    }
}
