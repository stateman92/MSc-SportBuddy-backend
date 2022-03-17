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
    @Field(key: "users") var users: [UUID]
    @Field(key: "groupEntries") var groupEntries: [UUID]
    @Timestamp(key: "createdAt", on: .create, format: .iso8601) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update, format: .iso8601) var updatedAt: Date?

    public init(id: UUID?, sportType: SportType, users: [UUID], groupEntries: [UUID]) {
        self.id = id
        self.sportType = sportType
        self.users = users
        self.groupEntries = groupEntries
    }
}

extension Group: PostgresModellable {
    static var schema: String {
        Constants.Schema.groups.rawValue
    }

    convenience init() {
        self.init(id: .init(), sportType: .athletics, users: .empty, groupEntries: .empty)
    }

    convenience init(from dto: GroupDTO) {
        self.init(id: dto.primaryId, sportType: dto.sportType.model, users: dto.users, groupEntries: dto.groupEntries.map(\.primaryId))
    }

    var dto: GroupDTO {
        .init(primaryId: id ?? .init(), sportType: sportType.dto, users: users, groupEntries: .empty)
    }
}

extension GroupDTO {
    var model: Group {
        .init(from: self)
    }
}
