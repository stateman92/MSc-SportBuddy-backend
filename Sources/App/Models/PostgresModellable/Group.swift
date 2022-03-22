//
//  Group.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class Group {
    @ID(key: .id) var id: UUID?
    @Field(key: "sportType") var sportType: SportType
    @Field(key: "image") var image: String
    @Field(key: "users") var users: [UUID]
    @Field(key: "groupEntries") var groupEntries: [UUID]
    @Timestamp(key: "createdAt", on: .create, format: .iso8601) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update, format: .iso8601) var updatedAt: Date?

    /// Initialize an object.
    /// - Parameter id: the identifier.
    /// - Parameter image: the image of the group.
    /// - Parameter users: the users (participants) of the group.
    /// - Parameter groupEntries: the messages in the group.
    init(id: UUID?, sportType: SportType, image: String, users: [UUID], groupEntries: [UUID]) {
        self.id = id
        self.sportType = sportType
        self.image = image
        self.users = users
        self.groupEntries = groupEntries
    }
}

extension Group: PostgresModellable {
    /// The schema of the class.
    static var schema: String {
        Constants.Schema.groups.rawValue
    }

    /// Initialize an empty object for a new record in the schema.
    convenience init() {
        self.init(id: .init(), sportType: .athletics, image: .empty, users: .empty, groupEntries: .empty)
    }

    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    convenience init(from dto: GroupDTO) {
        self.init(id: dto.primaryId, sportType: dto.sportType.model, image: dto.image, users: dto.users, groupEntries: dto.groupEntries.map(\.primaryId))
    }

    /// Get the object as a DTO object.
    var dto: GroupDTO {
        .init(primaryId: id ?? .init(), sportType: sportType.dto, users: users, groupEntries: .empty, image: image)
    }
}

extension Group {
    /// Get the object as a DTO object.
    /// - Parameter groupEntries: the group entries. This is neccessary since these values aren't stored in the database's chat schema.
    /// - Returns: The DTO object.
    func dto(with groupEntries: [GroupEntryDTO]) -> GroupDTO {
        let modifiedDto = dto
        modifiedDto.groupEntries = groupEntries
        return modifiedDto
    }
}

extension GroupDTO {
    /// Get the DTO object as an object.
    var model: Group {
        .init(from: self)
    }
}
