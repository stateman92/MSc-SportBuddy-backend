//
//  SecretMiddleware.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class SecretMiddleware {
    var secret: String = .empty
    var header = "secret"
}

extension SecretMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        guard !secret.isEmpty else {
            return request.eventLoop.makeFailedFuture(Abort(.conflict, reason: "Incorrect X-Secret secret on the backend."))
        }
        guard request.headers.first(name: header) == secret else {
            return request.eventLoop.makeFailedFuture(Abort(.unauthorized, reason: "Incorrect X-Secret header."))
        }
        return next.respond(to: request)
    }
}
