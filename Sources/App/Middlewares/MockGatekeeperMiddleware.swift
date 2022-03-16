//
//  MockGatekeeperMiddleware.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class MockGatekeeperMiddleware: Initable { }

extension MockGatekeeperMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        next.respond(to: request)
    }
}
