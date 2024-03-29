//
//  Chat.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class Chat {
    enum Keys: String {
        case image
        case users
        case chatEntries
        case createdAt
        case updatedAt
    }

    @ID(key: .id) var id: UUID?
    @Field(Keys.image) var image: String
    @Field(Keys.users) var users: [UUID]
    @Field(Keys.chatEntries) var chatEntries: [UUID]
    @Timestamp(Keys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(Keys.updatedAt, on: .update) var updatedAt: Date?

    /// Initialize an object.
    /// - Parameter id: the identifier.
    /// - Parameter image: the image of the chat.
    /// - Parameter users: the users (participants) of the chat.
    /// - Parameter chatEntries: the messages in the chat.
    init(id: UUID?, image: String, users: [UUID], chatEntries: [UUID]) {
        self.id = id
        self.image = image
        self.users = users
        self.chatEntries = chatEntries
    }
}

extension Chat: PostgresModellable {
    /// The schema of the class.
    static var schema: String {
        Constants.Schema.chats.rawValue
    }

    /// Initialize an empty object for a new record in the schema.
    convenience init() {
        self.init(id: .init(), image: .init(), users: .init(), chatEntries: .init())
    }

    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    convenience init(from dto: ChatDTO) {
        self.init(id: dto.primaryId, image: dto.image, users: dto.users, chatEntries: dto.chatEntries.map(\.primaryId))
    }

    /// Get the object as a DTO object.
    var dto: ChatDTO {
        .init(chatEntries: .init(), image: image, primaryId: id ?? .init(), users: users, otherParty: .init())
    }
}

extension Chat {
    /// Get the object as a DTO object.
    /// - Parameter chatEntries: the chat entries. This is neccessary since these values aren't stored in the database's chat schema.
    /// - Returns: The DTO object.
    func dto(with chatEntries: [ChatEntryDTO], otherParty: String) -> ChatDTO {
        let modifiedDto = dto
        modifiedDto.chatEntries = chatEntries
        modifiedDto.otherParty = otherParty
        return modifiedDto
    }
}

extension ChatDTO {
    /// Get the DTO object as an object.
    var model: Chat {
        .init(from: self)
    }
}
