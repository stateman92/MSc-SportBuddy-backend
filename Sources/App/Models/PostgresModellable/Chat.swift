//
//  Chat.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class Chat {
    @ID(key: .id) var id: UUID?
    @Field(key: "users") var users: [UUID]
    @Field(key: "chatEntries") var chatEntries: [UUID]
    @Timestamp(key: "createdAt", on: .create, format: .iso8601) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update, format: .iso8601) var updatedAt: Date?

    public init(id: UUID?, users: [UUID], chatEntries: [UUID]) {
        self.id = id
        self.users = users
        self.chatEntries = chatEntries
    }
}

extension Chat: PostgresModellable {
    static var schema: String {
        Constants.Schema.chats.rawValue
    }

    convenience init() {
        self.init(id: .init(), users: .empty, chatEntries: .empty)
    }

    convenience init(from dto: ChatDTO) {
        self.init(id: dto.primaryId, users: dto.users, chatEntries: dto.chatEntries.map(\.primaryId))
    }

    var dto: ChatDTO {
        .init(primaryId: id ?? .init(), users: users, chatEntries: .empty)
    }
}

extension ChatDTO {
    var model: Chat {
        .init(from: self)
    }
}
