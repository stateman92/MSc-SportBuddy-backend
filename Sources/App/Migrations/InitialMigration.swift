//
//  InitialMigration.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Fluent
import FluentPostgresDriver
import Foundation

/// The representation of the initial migration of the database.
struct InitialMigration: Initable { }

// MARK: - Migration

extension InitialMigration: Migration {
    /// Prepare the migration.
    /// - Parameter database: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        createUsers(on: database)
            .transform(to: createChatEntries(on: database))
            .transform(to: createChats(on: database))
            .transform(to: createExerciseModels(on: database))
    }

    /// Revert the migration.
    /// - Parameter database: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        Constants.Schema
            .allCases
            .map { database.schema($0) }
            .map { $0.delete() }
            .flatten(on: database.eventLoop)
    }
}

// MARK: - Private methods

extension InitialMigration {
    /// Create the users schema.
    /// - Parameter database: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createUsers(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.users)
            .id()
            .field(User.Keys.name, .string)
            .field(User.Keys.email, .string)
            .field(User.Keys.password, .string)
            .field(User.Keys.profileImage, .string)
            .field(User.Keys.bio, .string)
            .field(User.Keys.isAdmin, .bool)
            .field(User.Keys.token, .string)
            .field(User.Keys.chats, .array(of: .uuid))
            .field(User.Keys.createdAt, .string)
            .field(User.Keys.updatedAt, .string)
            .create()
    }

    /// Create the chat entries schema.
    /// - Parameter database: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createChatEntries(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.chatEntries)
            .id()
            .field(ChatEntry.Keys.message, .string)
            .field(ChatEntry.Keys.timestamp, .int)
            .field(ChatEntry.Keys.sender, .uuid)
            .field(ChatEntry.Keys.deleted, .bool)
            .field(ChatEntry.Keys.createdAt, .string)
            .field(ChatEntry.Keys.updatedAt, .string)
            .create()
    }

    /// Create the chats schema.
    /// - Parameter database: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createChats(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.chats)
            .id()
            .field(Chat.Keys.image, .string)
            .field(Chat.Keys.users, .array(of: .uuid))
            .field(Chat.Keys.chatEntries, .array(of: .uuid))
            .field(Chat.Keys.createdAt, .string)
            .field(Chat.Keys.updatedAt, .string)
            .create()
    }

    /// Create the exerciseModels schema.
    /// - Parameter database: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createExerciseModels(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.exerciseModels)
            .id()
            .field(ExerciseModel.Keys.sequence, .array(of: .custom(ExerciseMoment.self)))
            .field(ExerciseModel.Keys.sequenceCount, .int32)
            .field(ExerciseModel.Keys.delay, .double)
            .field(ExerciseModel.Keys.createdAt, .string)
            .field(ExerciseModel.Keys.updatedAt, .string)
            .create()
    }
}
