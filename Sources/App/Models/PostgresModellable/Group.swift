//
//  Group.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class Group {
    typealias IDValue = UUID
    
    @ID(key: .id) var id: UUID?
    @Field(key: "sportType") var sportType: SportType
    @Field(key: "users") var users: [UUID]
    @Field(key: "groupEntries") var groupEntries: [GroupEntry]

    public init(id: UUID?, sportType: SportType, users: [UUID], groupEntries: [GroupEntry]) {
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
        self.init(id: UUID(), sportType: .athletics, users: .empty, groupEntries: .empty)
    }

    convenience init(from dto: GroupDTO) {
        self.init(id: dto.primaryId, sportType: dto.sportType.model, users: dto.users, groupEntries: dto.groupEntries.map(\.model))
    }

    var dto: GroupDTO {
        .init(primaryId: id ?? UUID(), sportType: sportType.dto, users: users, groupEntries: groupEntries.map(\.dto))
    }
}

extension GroupDTO {
    var model: Group {
        .init(from: self)
    }
}
