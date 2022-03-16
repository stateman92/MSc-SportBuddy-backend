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
        try autoMigrate().wait()

        try addInitialData()
    }

    private func addInitialData() throws {
        try User.query(on: db).delete().wait()
        try ChatEntry.query(on: db).delete().wait()
        try Chat.query(on: db).delete().wait()
        try GroupEntry.query(on: db).delete().wait()
        try Group.query(on: db).delete().wait()
        try Exercise.query(on: db).delete().wait()

        let firstUser = User(id: UUID(),
                             name: "name1 name1",
                             email: "email email1",
                             password: "password1 password1",
                             profileImageUrl: "profileImageUrl1 profileImageUrl1",
                             token: Token(token: UUID(),
                                          tokenGeneratedTime: 123),
                             sports: [.athletics,
                                      .workout],
                             chats: [UUID(),
                                     UUID()])
        try firstUser.create(on: db).wait()

        let secondUser = User(id: UUID(),
                              name: "name2 name2",
                              email: "email2 email2",
                              password: "password2 password2",
                              profileImageUrl: "profileImageUrl2 profileImageUrl2",
                              token: Token(token: UUID(),
                                           tokenGeneratedTime: 123456),
                              sports: [.athletics,
                                       .yoga],
                              chats: [UUID(),
                                      UUID()])
        try secondUser.create(on: db).wait()

        let thirdUser = User(id: UUID(),
                             name: "name3 name3",
                             email: "email3 email3",
                             password: "password3 password3",
                             profileImageUrl: "profileImageUrl3 profileImageUrl3",
                             token: Token(token: UUID(),
                                          tokenGeneratedTime: 123456789),
                             sports: [.workout,
                                      .yoga],
                             chats: [UUID(),
                                     UUID()])
        try thirdUser.create(on: db).wait()

        let firstChatEntry = ChatEntry(id: UUID(), message: "Hello!", timestamp: Date().secondsSince1970, sender: firstUser.id!)
        try firstChatEntry.create(on: db).wait()
        let secondChatEntry = ChatEntry(id: UUID(), message: "Hello there!", timestamp: Date().secondsSince1970, sender: secondUser.id!)
        try secondChatEntry.create(on: db).wait()

        let chat = Chat(id: UUID(),
                        users: [firstUser.id!,
                                secondUser.id!,
                                thirdUser.id!],
                        chatEntries: [firstChatEntry,
                                      secondChatEntry])
        try chat.create(on: db).wait()

        let firstGroupEntry = GroupEntry(id: UUID(), message: "First group message.", timestamp: Date().secondsSince1970, sender: thirdUser.id!)
        try firstGroupEntry.create(on: db).wait()

        let group = Group(id: UUID(),
                          sportType: .workout,
                          users: [firstUser.id!,
                                  thirdUser.id!],
                          groupEntries: [firstGroupEntry])
        try group.create(on: db).wait()

        let exercise = Exercise(id: UUID(),
                                exerciseType: .running,
                                previewImageUrl: "previewImageUrl",
                                exerciseVideoUrl: "exerciseVideoUrl",
                                fractions: [.init(time: .init(fromTime: 0, toTime: 1), motionType: .runningMotion1),
                                            .init(time: .init(fromTime: 2, toTime: 3), motionType: .runningMotion3)])
        try exercise.create(on: db).wait()
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
