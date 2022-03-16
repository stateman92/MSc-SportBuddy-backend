//
//  ChatEntry.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class ChatEntry {
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

extension ChatEntry: PostgresModellable {
    static var schema: String {
        Constants.Schema.chatEntries.rawValue
    }

    convenience init() {
        self.init(id: .init(), message: .empty, timestamp: .zero, sender: .init())
    }

    convenience init(from dto: ChatEntryDTO) {
        self.init(id: dto.primaryId, message: dto.message, timestamp: dto.timestamp, sender: dto.sender)
    }

    var dto: ChatEntryDTO {
        .init(primaryId: id ?? .init(), message: message, timestamp: timestamp, sender: sender)
    }
}

extension ChatEntryDTO {
    var model: ChatEntry {
        .init(from: self)
    }
}
