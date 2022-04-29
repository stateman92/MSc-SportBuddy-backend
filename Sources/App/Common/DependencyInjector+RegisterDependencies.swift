//
//  DependencyInjector+RegisterDependencies.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

import Resolver

extension DependencyInjector {
    /// Register all the dependencies of the application.
    public static func registerDependencies() {
        Resolver.defaultScope = Resolver.shared

        registerControllers()
        registerServices()
        registerMiddlewares()
        registerMigrations()
    }
}
