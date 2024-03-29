//
//  ChatEntry.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class ChatEntry {
    enum Keys: String {
        case message
        case timestamp
        case sender
        case deleted
        case createdAt
        case updatedAt
    }

    @ID(key: .id) var id: UUID?
    @Field(Keys.message) var message: String
    @Field(Keys.timestamp) var timestamp: Int
    @Field(Keys.sender) var sender: UUID
    @Field(Keys.deleted) var deleted: Bool
    @Timestamp(Keys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(Keys.updatedAt, on: .update) var updatedAt: Date?

    /// Initialize an object.
    /// - Parameter id: the identifier.
    /// - Parameter message: the message of the entry.
    /// - Parameter timestamp: the original timestamp of the entry.
    /// - Parameter sender: the sender's id.
    /// - Parameter deleted: whether the entry is deleted (soft deletion).
    init(id: UUID?, message: String, timestamp: Int, sender: UUID, deleted: Bool) {
        self.id = id
        self.message = message
        self.timestamp = timestamp
        self.sender = sender
        self.deleted = deleted
    }
}

extension ChatEntry: PostgresModellable {
    /// The schema of the class.
    static var schema: String {
        Constants.Schema.chatEntries.rawValue
    }

    /// Initialize an empty object for a new record in the schema.
    convenience init() {
        self.init(id: .init(), message: .init(), timestamp: .zero, sender: .init(), deleted: false)
    }

    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    convenience init(from dto: ChatEntryDTO) {
        self.init(id: dto.primaryId, message: dto.message, timestamp: dto.timestamp, sender: dto.sender, deleted: dto.deleted)
    }

    /// Get the object as a DTO object.
    var dto: ChatEntryDTO {
        .init(primaryId: id ?? .init(), message: message, timestamp: timestamp, sender: sender, deleted: deleted)
    }
}

extension ChatEntryDTO {
    /// Get the DTO object as an object.
    var model: ChatEntry {
        .init(from: self)
    }
}
