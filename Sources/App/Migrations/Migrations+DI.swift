//
//  Migrations+DI.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

extension DependencyInjector {
    /// Register all the migrations of the application.
    static func registerMigrations() {
        resolver.register { InitialMigration() }
    }
}
