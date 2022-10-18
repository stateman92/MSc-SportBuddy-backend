//
//  Database+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

extension Database {
    /// Get a `SchemaBuilder`.
    /// - Parameter tableName: the name of the schema.
    /// - Returns: The `SchemaBuilder`.
    func schema(_ tableName: Constants.Schema) -> SchemaBuilder {
        schema(tableName.rawValue)
    }

    /// Remove all data, and store the admin user.
    func reset() -> EventLoopFuture<Void> {
        removeAllData()
            .flatMap { addAdmin() }
    }

    /// Remove all data, and store the initial data.
    func clear() -> EventLoopFuture<Void> {
        removeAllData()
            .flatMap { _ in addInitialData() }
            .flatMap { addAdmin() }
    }

    /// Remove all data.
    private func removeAllData() -> EventLoopFuture<Void> {
        User.deleteAll(on: self)
            .flatMap { _ in ChatEntry.deleteAll(on: self) }
            .flatMap { _ in Chat.deleteAll(on: self) }
    }

    /// Add the initial data.
    private func addInitialData() -> EventLoopFuture<Void> {
        let firstChatId = UUID()
        let firstUser = User(id: UUID(),
                             name: "name1 name1",
                             email: "email email1",
                             password: "password1 password1",
                             profileImage: "profileImage1 profileImage1",
                             bio: "bio 1",
                             isAdmin: false,
                             token: Token(),
                             chats: [firstChatId])

        let secondUser = User(id: UUID(),
                              name: "name2 name2",
                              email: "email2 email2",
                              password: "password2 password2",
                              profileImage: "profileImage2 profileImage2",
                              bio: "bio 2",
                              isAdmin: false,
                              token: Token(),
                              chats: [firstChatId])

        let thirdUser = User(id: UUID(),
                             name: "name3 name3",
                             email: "email3 email3",
                             password: "password3 password3",
                             profileImage: "profileImage3 profileImage3",
                             bio: "bio 3",
                             isAdmin: false,
                             token: Token(),
                             chats: [])

        let firstChatEntry = ChatEntry(id: UUID(), message: "Hello!", timestamp: Date().secondsSince1970, sender: firstUser.id!, deleted: false)
        let secondChatEntry = ChatEntry(id: UUID(), message: "Hello there!", timestamp: Date().secondsSince1970, sender: secondUser.id!, deleted: false)

        let chat = Chat(id: firstChatId,
                        image: .init(),
                        users: [firstUser.id!,
                                secondUser.id!,
                                thirdUser.id!],
                        chatEntries: [firstChatEntry.id!,
                                      secondChatEntry.id!])
        return firstUser.create(on: self)
            .flatMap { _ in secondUser.create(on: self) }
            .flatMap { _ in thirdUser.create(on: self) }
            .flatMap { _ in firstChatEntry.create(on: self) }
            .flatMap { _ in secondChatEntry.create(on: self) }
            .flatMap { _ in chat.create(on: self) }
    }

    /// Add the admin user.
    private func addAdmin() -> EventLoopFuture<Void> {
        @LazyInjected var authenticationService: AuthenticationService
        return User(id: .init(), name: "Admin",
                    email: "admin@admin.com",
                    password: authenticationService.forceHash(password: "admin")!,
                    profileImage: .init(),
                    bio: .init(),
                    isAdmin: true,
                    token: .init(),
                    chats: .init())
        .save(on: self)
    }
}
