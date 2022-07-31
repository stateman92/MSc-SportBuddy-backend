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
        (DependencyInjector.resolve() as EmailService).setup(app: self)
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
        migrations.add(DependencyInjector.resolve() as InitialMigration)
        if !isTesting() {
            try autoMigrate().wait()
        }

        try addInitialData(db)
    }

    /// Add initial data to the database.
    /// - Parameter database: the database.
    private func addInitialData(_ database: Database) throws {
        try User.deleteAll(on: database).wait()
        try ChatEntry.deleteAll(on: database).wait()
        try Chat.deleteAll(on: database).wait()
        try GroupEntry.deleteAll(on: database).wait()
        try Group.deleteAll(on: database).wait()
        try Exercise.deleteAll(on: database).wait()

        let firstUserId = UUID()
        let secondUserId = UUID()
        let thirdUserId = UUID()
        let firstGroup = Group(id: UUID(), sportType: .athletics, image: .init(), users: [firstUserId, secondUserId], groupEntries: [])
        let secondGroup = Group(id: UUID(), sportType: .workout, image: .init(), users: [secondUserId, thirdUserId], groupEntries: [])
        let thirdGroup = Group(id: UUID(), sportType: .yoga, image: .init(), users: [firstUserId, thirdUserId], groupEntries: [])

        let firstChatId = UUID()
        let firstUser = User(id: UUID(),
                             name: "name1 name1",
                             email: "email email1",
                             password: "password1 password1",
                             profileImage: "profileImage1 profileImage1",
                             bio: "bio 1",
                             token: Token(),
                             chats: [firstChatId],
                             groups: [firstGroup.id!,
                                      thirdGroup.id!])
        try firstUser.create(on: database).wait()

        let secondUser = User(id: UUID(),
                              name: "name2 name2",
                              email: "email2 email2",
                              password: "password2 password2",
                              profileImage: "profileImage2 profileImage2",
                              bio: "bio 2",
                              token: Token(),
                              chats: [firstChatId],
                              groups: [firstGroup.id!,
                                       secondGroup.id!])
        try secondUser.create(on: database).wait()

        let thirdUser = User(id: UUID(),
                             name: "name3 name3",
                             email: "email3 email3",
                             password: "password3 password3",
                             profileImage: "profileImage3 profileImage3",
                             bio: "bio 3",
                             token: Token(),
                             chats: [],
                             groups: [secondGroup.id!,
                                      thirdGroup.id!])
        try thirdUser.create(on: database).wait()

        let firstChatEntry = ChatEntry(id: UUID(), message: "Hello!", timestamp: Date().secondsSince1970, sender: firstUser.id!, deleted: false)
        try firstChatEntry.create(on: database).wait()
        let secondChatEntry = ChatEntry(id: UUID(), message: "Hello there!", timestamp: Date().secondsSince1970, sender: secondUser.id!, deleted: false)
        try secondChatEntry.create(on: database).wait()

        let chat = Chat(id: firstChatId,
                        image: .init(),
                        users: [firstUser.id!,
                                secondUser.id!,
                                thirdUser.id!],
                        chatEntries: [firstChatEntry.id!,
                                      secondChatEntry.id!])
        try chat.create(on: database).wait()

        let firstGroupEntry = GroupEntry(id: UUID(), message: "First group message.", timestamp: Date().secondsSince1970, sender: thirdUser.id!, deleted: false)
        try firstGroupEntry.create(on: database).wait()

        try firstGroup.create(on: database).wait()
        try secondGroup.create(on: database).wait()
        try thirdGroup.create(on: database).wait()

        let exercise = Exercise(id: UUID(),
                                exerciseType: .running,
                                previewImage: "previewImage",
                                exerciseVideoUrl: "exerciseVideoUrl",
                                fractions: [.init(time: .init(fromTime: 0, toTime: 1), motionType: .runningMotion1),
                                            .init(time: .init(fromTime: 2, toTime: 3), motionType: .runningMotion3)])
        try exercise.create(on: database).wait()
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
        if !isTesting() {
            middleware.use(DependencyInjector.resolve() as GatekeeperMiddleware)
        }
    }

    /// Setup the rate cors policy middleware.
    private func configureCorsPolicy() {
        middleware.use(DependencyInjector.resolve() as CORSMiddleware, at: .beginning)
    }
}

extension Application {
    /// Setup the repositories.
    private func reigsterRepositories() {
        if isTesting() {
            repositories.register(.chats) { MockRepository<Chat>(req: $0) }
            repositories.register(.chatEntries) { MockRepository<ChatEntry>(req: $0) }
            repositories.register(.exercises) { MockRepository<Exercise>(req: $0) }
            repositories.register(.groups) { MockRepository<Group>(req: $0) }
            repositories.register(.groupEntries) { MockRepository<GroupEntry>(req: $0) }
            repositories.register(.users) { MockRepository<User>(req: $0) }
        } else {
            repositories.register(.chats) { RepositoryImpl<Chat>(req: $0) }
            repositories.register(.chatEntries) { RepositoryImpl<ChatEntry>(req: $0) }
            repositories.register(.exercises) { RepositoryImpl<Exercise>(req: $0) }
            repositories.register(.groups) { RepositoryImpl<Group>(req: $0) }
            repositories.register(.groupEntries) { RepositoryImpl<GroupEntry>(req: $0) }
            repositories.register(.users) { RepositoryImpl<User>(req: $0) }
        }
    }
}

extension Application {
    /// Setup the routes.
    private func setupRoutes() throws {
        try App.routes(self,
                       backend: DependencyInjector.resolve() as SportBuddyController,
                       authForBearer: DependencyInjector.resolve() as AuthorizationService)
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
