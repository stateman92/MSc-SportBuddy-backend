//
//  Chat.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class Chat {
    typealias IDValue = UUID

    @ID(key: .id) var id: UUID?
    @Field(key: "users") var users: [UUID]
    @Field(key: "chatEntries") var chatEntries: [ChatEntry]

    public init(id: UUID?, users: [UUID], chatEntries: [ChatEntry]) {
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
        self.init(id: UUID(), users: .empty, chatEntries: .empty)
    }

    convenience init(from dto: ChatDTO) {
        self.init(id: dto.primaryId, users: dto.users, chatEntries: dto.chatEntries.map(\.model))
    }

    var dto: ChatDTO {
        .init(primaryId: id ?? UUID(), users: users, chatEntries: chatEntries.map(\.dto))
    }
}

extension ChatDTO {
    var model: Chat {
        .init(from: self)
    }
}
