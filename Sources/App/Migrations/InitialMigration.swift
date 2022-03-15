//
//  InitialMigration.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Fluent
import FluentPostgresDriver

struct InitialMigration { }

extension InitialMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Constants.Schema.users.rawValue)
            .id()
            .field("projectId", .uuid)
            .field("title", .string)
            .field("question", .string)
            .field("answer", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        Constants.Schema
            .allCases
            .map(\.rawValue)
            .map { database.schema($0).delete() }
            .flatten(on: database.eventLoop)
    }
}

extension InitialMigration {
}
