//
//  Middlewares+DI.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

import Vapor
import Gatekeeper

extension DependencyInjector {
    /// Register all the middlewares of the application.
    static func registerMiddlewares() {
        resolver.register { SecretMiddleware() }
        resolver.register { CORSMiddleware() }
        resolver.register { GatekeeperMiddleware() }
    }
}
