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

extension InitialMigration: Migration {
    /// Prepare the migration.
    /// - Parameter on: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        createUsers(on: database)
            .transform(to: createChatEntries(on: database))
            .transform(to: createGroupEntries(on: database))
            .transform(to: createChats(on: database))
            .transform(to: createGroups(on: database))
            .transform(to: createExercises(on: database))
    }

    /// Revert the migration.
    /// - Parameter on: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        Constants.Schema
            .allCases
            .map { database.schema($0) }
            .map { $0.delete() }
            .flatten(on: database.eventLoop)
    }
}

extension InitialMigration {
    /// Create the users schema.
    /// - Parameter on: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createUsers(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.users)
            .id()
            .field("name", .string)
            .field("email", .string)
            .field("password", .string)
            .field("profileImage", .string)
            .field("bio", .string)
            .field("token", .string)
            .field("chats", .array(of: .uuid))
            .field("groups", .array(of: .uuid))
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    /// Create the chat entries schema.
    /// - Parameter on: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createChatEntries(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.chatEntries)
            .id()
            .field("message", .string)
            .field("timestamp", .int)
            .field("sender", .uuid)
            .field("deleted", .bool)
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    /// Create the group entries schema.
    /// - Parameter on: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createGroupEntries(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.groupEntries)
            .id()
            .field("message", .string)
            .field("timestamp", .int)
            .field("sender", .uuid)
            .field("deleted", .bool)
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    /// Create the chats schema.
    /// - Parameter on: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createChats(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.chats)
            .id()
            .field("users", .array(of: .uuid))
            .field("image", .string)
            .field("chatEntries", .array(of: .uuid))
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    /// Create the groups schema.
    /// - Parameter on: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createGroups(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.groups)
            .id()
            .field("sportType", .string)
            .field("image", .string)
            .field("users", .array(of: .uuid))
            .field("groupEntries", .array(of: .uuid))
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    /// Create the exercises schema.
    /// - Parameter on: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    private func createExercises(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.exercises)
            .id()
            .field("exerciseType", .string)
            .field("previewImage", .string)
            .field("exerciseVideoUrl", .string)
            .field("fractions", .array(of: .string))
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }
}
