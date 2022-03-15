//
//  ChatEntry.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class ChatEntry {
    typealias IDValue = UUID

    @ID(key: .id) var id: UUID?
    @Field(key: "message") var message: String
    @Field(key: "timestamp") var timestamp: Int
    @Field(key: "sender") var sender: UUID

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
        self.init(id: UUID(), message: .empty, timestamp: .zero, sender: .init())
    }

    convenience init(from dto: ChatEntryDTO) {
        self.init(id: dto.primaryId, message: dto.message, timestamp: dto.timestamp, sender: dto.sender)
    }

    var dto: ChatEntryDTO {
        .init(primaryId: id ?? UUID(), message: message, timestamp: timestamp, sender: sender)
    }
}

extension ChatEntryDTO {
    var model: ChatEntry {
        .init(from: self)
    }
}
