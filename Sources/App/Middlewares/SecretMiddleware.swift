//
//  SecretMiddleware.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

/// A middleware that checks that is there a value in the header that matches the secret.
final class SecretMiddleware: Initable {
    // MARK: Properties

    private let secret: String = .init()
    private let header = "secret"
}

// MARK: - Middleware

extension SecretMiddleware: Middleware {
    /// Respond to the given request.
    /// - Parameter req: the request.
    /// - Parameter next: the next responder (maybe another middleware or the application).
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func respond(to req: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        guard !secret.isEmpty else {
            return req.eventLoop.makeFailedFuture(Abort(.conflict, reason: "Incorrect X-Secret secret on the backend."))
        }
        guard req.headers.first(name: header) == secret else {
            return req.eventLoop.makeFailedFuture(Abort(.unauthorized, reason: "Incorrect X-Secret header."))
        }
        return next.respond(to: req)
    }
}
