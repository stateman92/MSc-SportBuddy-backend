//
//  GroupEntry.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class GroupEntry {
    @ID(key: .id) var id: UUID?
    @Field(key: "message") var message: String
    @Field(key: "timestamp") var timestamp: Int
    @Field(key: "sender") var sender: UUID
    @Timestamp(key: "createdAt", on: .create, format: .iso8601) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update, format: .iso8601) var updatedAt: Date?

    public init(id: UUID?, message: String, timestamp: Int, sender: UUID) {
        self.id = id
        self.message = message
        self.timestamp = timestamp
        self.sender = sender
    }
}

extension GroupEntry: PostgresModellable {
    static var schema: String {
        Constants.Schema.groupEntries.rawValue
    }

    convenience init() {
        self.init(id: .init(), message: .empty, timestamp: .zero, sender: .init())
    }

    convenience init(from dto: GroupEntryDTO) {
        self.init(id: dto.primaryId, message: dto.message, timestamp: dto.timestamp, sender: dto.sender)
    }

    var dto: GroupEntryDTO {
        .init(primaryId: id ?? .init(), message: message, timestamp: timestamp, sender: sender)
    }
}

extension GroupEntryDTO {
    var model: GroupEntry {
        .init(from: self)
    }
}
