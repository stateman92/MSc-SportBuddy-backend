//
//  Application+Extensions.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor
import Gatekeeper
import SendGrid

extension Application {
    public func setup() throws {
        try setupDatabase()
        configureMiddlewares()
        try setupRoutes()
        (DependencyInjector.resolve() as EmailServiceProtocol).setup(app: self)
    }
}

extension Application {
    private func setupDatabase() throws {
        var tlsConfiguration: TLSConfiguration = .makeClientConfiguration()
        tlsConfiguration.certificateVerification = .none
        databases.use(.postgres(hostname: Environment.get(.hostname),
                                username: Environment.get(.username),
                                password: Environment.get(.password),
                                database: Environment.get(.database),
                                tlsConfiguration: tlsConfiguration),
                      as: .psql,
                      isDefault: true)
        try setupMigrations()
    }

    private func setupMigrations() throws {
        migrations.add(DependencyInjector.resolve() as InitialMigration)
    }
}

extension Application {
    private func configureMiddlewares() {
        configureRateLimiting()
        configureCorsPolicy()
    }

    private func configureRateLimiting() {
        caches.use(.memory)
        gatekeeper.config = Constants.gatekeeperConfig
        if !isTesting() {
            middleware.use(DependencyInjector.resolve() as GatekeeperMiddleware)
        }
    }

    private func configureCorsPolicy() {
        middleware.use(DependencyInjector.resolve() as CORSMiddleware, at: .beginning)
    }
}

extension Application {
    private func setupRoutes() throws {
        try App.routes(self,
                       backend: DependencyInjector.resolve() as SportBuddyController,
                       authForBearer: DependencyInjector.resolve() as AuthorizationServiceProtocol)
    }
}
