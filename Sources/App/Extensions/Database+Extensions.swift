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
            .flatMap { _ in ExerciseModel.deleteAll(on: self) }
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

        let firstExerciseModel = ExerciseModel(
            id: .init(),
            sequence: [
                .init(
                    armCharacteristics: .init(
                        firstHalfPositionType: .around90,
                        firstFullPositionType: .around90,
                        secondFullPositionType: .around90,
                        secondHalfPositionType: .around90,
                        distanceType: .around1,
                        type: .arms
                    ),
                    legCharacteristics: .init(
                        firstHalfPositionType: .around180,
                        firstFullPositionType: .around90,
                        secondFullPositionType: .around90,
                        secondHalfPositionType: .around180,
                        distanceType: .around0,
                        type: .legs
                    ),
                    errors: [
                        .init(
                            characteristics: .init(
                                distanceType: .around1,
                                type: .legs
                            ),
                            error: "Tedd összébb a lábakat!"
                        ),
                        .init(
                            characteristics: .init(
                                distanceType: .around0,
                                type: .arms
                            ),
                            error: "Tedd szét a kezeket!"
                        )
                    ]
                )
            ],
            sequenceCount: 20,
            delay: 1,
            videoId: "videoId",
            name: "name",
            details: "details")

        let secondExerciseModel = ExerciseModel(
            id: .init(),
            sequence: [
                .init(
                    armCharacteristics: .init(
                        firstHalfPositionType: .around90,
                        firstFullPositionType: .around180,
                        secondFullPositionType: .around180,
                        secondHalfPositionType: .around90,
                        distanceType: .around1,
                        type: .arms
                    ),
                    legCharacteristics: .init(
                        firstHalfPositionType: .around180,
                        firstFullPositionType: .around90,
                        secondFullPositionType: .around90,
                        secondHalfPositionType: .around180,
                        distanceType: .around1,
                        type: .legs
                    ),
                    errors: []
                ),
                .init(
                    armCharacteristics: .init(
                        firstHalfPositionType: .around135,
                        firstFullPositionType: .around180,
                        secondFullPositionType: .around180,
                        secondHalfPositionType: .around135,
                        distanceType: .around1,
                        type: .arms
                    ),
                    legCharacteristics: .init(
                        firstHalfPositionType: .around180,
                        firstFullPositionType: .around90,
                        secondFullPositionType: .around90,
                        secondHalfPositionType: .around180,
                        distanceType: .around1,
                        type: .legs
                    ),
                    errors: []
                ),
                .init(
                    armCharacteristics: .init(
                        firstHalfPositionType: .around180,
                        firstFullPositionType: .around180,
                        secondFullPositionType: .around180,
                        secondHalfPositionType: .around180,
                        distanceType: .around1,
                        type: .arms
                    ),
                    legCharacteristics: .init(
                        firstHalfPositionType: .around180,
                        firstFullPositionType: .around90,
                        secondFullPositionType: .around90,
                        secondHalfPositionType: .around180,
                        distanceType: .around1,
                        type: .legs
                    ),
                    errors: []
                )
            ],
            sequenceCount: 20,
            delay: 1,
            videoId: "videoId2",
            name: "name2",
            details: "details2")


        return firstUser.create(on: self)
            .flatMap { _ in secondUser.create(on: self) }
            .flatMap { _ in thirdUser.create(on: self) }
            .flatMap { _ in firstChatEntry.create(on: self) }
            .flatMap { _ in secondChatEntry.create(on: self) }
            .flatMap { _ in chat.create(on: self) }
            .flatMap { _ in firstExerciseModel.create(on: self) }
            .flatMap { _ in secondExerciseModel.create(on: self) }
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
