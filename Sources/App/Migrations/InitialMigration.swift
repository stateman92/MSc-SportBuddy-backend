//
//  InitialMigration.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Fluent
import FluentPostgresDriver
import Foundation

struct InitialMigration: Initable { }

extension InitialMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        createUsers(on: database)
            .transform(to: createChatEntries(on: database))
            .transform(to: createGroupEntries(on: database))
            .transform(to: createChats(on: database))
            .transform(to: createGroups(on: database))
            .transform(to: createExercises(on: database))
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        Constants.Schema
            .allCases
            .map { database.schema($0) }
            .map { $0.delete() }
            .flatten(on: database.eventLoop)
    }
}

extension InitialMigration {
    private func createUsers(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.users)
            .id()
            .field("name", .string)
            .field("email", .string)
            .field("password", .string)
            .field("profileImageUrl", .string)
            .field("token", .string)
            .field("sports", .array(of: .string))
            .field("chats", .array(of: .uuid))
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    private func createChatEntries(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.chatEntries)
            .id()
            .field("message", .string)
            .field("timestamp", .int)
            .field("sender", .uuid)
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    private func createGroupEntries(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.groupEntries)
            .id()
            .field("message", .string)
            .field("timestamp", .int)
            .field("sender", .uuid)
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    private func createChats(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.chats)
            .id()
            .field("users", .array(of: .uuid))
            .field("chatEntries", .array(of: .uuid))
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    private func createGroups(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.groups)
            .id()
            .field("sportType", .string)
            .field("users", .array(of: .uuid))
            .field("groupEntries", .array(of: .uuid))
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }

    private func createExercises(on database: Database) -> EventLoopFuture<Void> {
        database.schema(.exercises)
            .id()
            .field("exerciseType", .string)
            .field("previewImageUrl", .string)
            .field("exerciseVideoUrl", .string)
            .field("fractions", .array(of: .string))
            .field("createdAt", .string)
            .field("updatedAt", .string)
            .create()
    }
}
