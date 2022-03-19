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
    @Field(key: "deleted") var deleted: Bool
    @Timestamp(key: "createdAt", on: .create, format: .iso8601) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update, format: .iso8601) var updatedAt: Date?

    public init(id: UUID?, message: String, timestamp: Int, sender: UUID, deleted: Bool) {
        self.id = id
        self.message = message
        self.timestamp = timestamp
        self.sender = sender
        self.deleted = deleted
    }
}

extension GroupEntry: PostgresModellable {
    static var schema: String {
        Constants.Schema.groupEntries.rawValue
    }

    convenience init() {
        self.init(id: .init(), message: .empty, timestamp: .zero, sender: .init(), deleted: false)
    }

    convenience init(from dto: GroupEntryDTO) {
        self.init(id: dto.primaryId, message: dto.message, timestamp: dto.timestamp, sender: dto.sender, deleted: dto.deleted)
    }

    var dto: GroupEntryDTO {
        .init(primaryId: id ?? .init(), message: message, timestamp: timestamp, sender: sender, deleted: deleted)
    }
}

extension GroupEntryDTO {
    var model: GroupEntry {
        .init(from: self)
    }
}
