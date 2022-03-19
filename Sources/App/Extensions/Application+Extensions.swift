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
        if !isTesting() {
            try autoMigrate().wait()
        }

        try addInitialData(db)
    }

    private func addInitialData(_ database: Database) throws {
        try User.query(on: database).delete().wait()
        try ChatEntry.query(on: database).delete().wait()
        try Chat.query(on: database).delete().wait()
        try GroupEntry.query(on: database).delete().wait()
        try Group.query(on: database).delete().wait()
        try Exercise.query(on: database).delete().wait()

        let firstChatId = UUID()
        let firstUser = User(id: UUID(),
                             name: "name1 name1",
                             email: "email email1",
                             password: "password1 password1",
                             profileImageUrl: "profileImageUrl1 profileImageUrl1",
                             token: Token(),
                             sports: [.athletics,
                                      .workout],
                             chats: [firstChatId])
        try firstUser.create(on: database).wait()

        let secondUser = User(id: UUID(),
                              name: "name2 name2",
                              email: "email2 email2",
                              password: "password2 password2",
                              profileImageUrl: "profileImageUrl2 profileImageUrl2",
                              token: Token(),
                              sports: [.athletics,
                                       .yoga],
                              chats: [firstChatId])
        try secondUser.create(on: database).wait()

        let thirdUser = User(id: UUID(),
                             name: "name3 name3",
                             email: "email3 email3",
                             password: "password3 password3",
                             profileImageUrl: "profileImageUrl3 profileImageUrl3",
                             token: Token(),
                             sports: [.workout,
                                      .yoga],
                             chats: [])
        try thirdUser.create(on: database).wait()

        let firstChatEntry = ChatEntry(id: UUID(), message: "Hello!", timestamp: Date().secondsSince1970, sender: firstUser.id!, deleted: false)
        try firstChatEntry.create(on: database).wait()
        let secondChatEntry = ChatEntry(id: UUID(), message: "Hello there!", timestamp: Date().secondsSince1970, sender: secondUser.id!, deleted: false)
        try secondChatEntry.create(on: database).wait()

        let chat = Chat(id: firstChatId,
                        users: [firstUser.id!,
                                secondUser.id!,
                                thirdUser.id!],
                        chatEntries: [firstChatEntry.id!,
                                      secondChatEntry.id!])
        try chat.create(on: database).wait()

        let firstGroupEntry = GroupEntry(id: UUID(), message: "First group message.", timestamp: Date().secondsSince1970, sender: thirdUser.id!, deleted: false)
        try firstGroupEntry.create(on: database).wait()

        let group = Group(id: UUID(),
                          sportType: .workout,
                          users: [firstUser.id!,
                                  thirdUser.id!],
                          groupEntries: [firstGroupEntry.id!])
        try group.create(on: database).wait()

        let exercise = Exercise(id: UUID(),
                                exerciseType: .running,
                                previewImageUrl: "previewImageUrl",
                                exerciseVideoUrl: "exerciseVideoUrl",
                                fractions: [.init(time: .init(fromTime: 0, toTime: 1), motionType: .runningMotion1),
                                            .init(time: .init(fromTime: 2, toTime: 3), motionType: .runningMotion3)])
        try exercise.create(on: database).wait()
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
