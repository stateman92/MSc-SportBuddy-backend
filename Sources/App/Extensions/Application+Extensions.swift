//
//  Application+Extensions.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor
import Gatekeeper
import FluentPostgresDriver
import SendGrid

extension Application {
    /// Setup the application.
    public func setup() throws {
        try setupDatabase()
        configureMiddlewares()
        try setupRoutes()
        @LazyInjected var emailService: EmailService
        emailService.setup(app: self)
        reigsterRepositories()
    }
}

extension Application {
    /// Setup the database.
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

    /// Setup the migrations.
    private func setupMigrations() throws {
        @LazyInjected var initialMigration: InitialMigration
        migrations.add(initialMigration)
        if !isTesting {
            try autoMigrate().wait()
        }

        try addInitialData(db)
    }

    /// Add initial data to the database.
    /// - Parameter database: the database.
    private func addInitialData(_ database: Database) throws {
        try database.clear().wait()
    }
}

extension Application {
    /// Setup the middlewares.
    private func configureMiddlewares() {
        configureRateLimiting()
        configureCorsPolicy()
    }

    /// Setup the rate limiting middleware.
    private func configureRateLimiting() {
        caches.use(.memory)
        gatekeeper.config = Constants.gatekeeperConfig
        if !isTesting {
            @LazyInjected var gatekeeperMiddleware: GatekeeperMiddleware
            middleware.use(gatekeeperMiddleware)
        }
    }

    /// Setup the rate cors policy middleware.
    private func configureCorsPolicy() {
        @LazyInjected var corsMiddleware: CORSMiddleware
        middleware.use(corsMiddleware, at: .beginning)
    }
}

extension Application {
    /// Setup the repositories.
    private func reigsterRepositories() {
        if isTesting {
            repositories.register(.chats) { MockRepository<Chat>(req: $0) }
            repositories.register(.chatEntries) { MockRepository<ChatEntry>(req: $0) }
            repositories.register(.users) { MockRepository<User>(req: $0) }
            repositories.register(.exerciseModels) { MockRepository<ExerciseModel>(req: $0) }
        } else {
            repositories.register(.chats) { RepositoryImpl<Chat>(req: $0) }
            repositories.register(.chatEntries) { RepositoryImpl<ChatEntry>(req: $0) }
            repositories.register(.users) { RepositoryImpl<User>(req: $0) }
            repositories.register(.exerciseModels) { RepositoryImpl<ExerciseModel>(req: $0) }
        }
    }
}

extension Application {
    /// Setup the routes.
    private func setupRoutes() throws {
        @LazyInjected var authorizationService: any AuthorizationService
        @LazyInjected var sportBuddyController: SportBuddyController
        try App.routes(self, backend: sportBuddyController, authForBearer: authorizationService)
        setupWebSocket()
    }

    /// Setup the websockets.
    private func setupWebSocket() {
        let webSocketHandler: WebSocketHandler = DependencyInjector.resolve(args: eventLoopGroup.next())
        webSocket { req, ws in
            webSocketHandler.connect(req, ws)
        }
    }
}
