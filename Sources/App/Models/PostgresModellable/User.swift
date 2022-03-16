//
//  User.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor
import FluentPostgresDriver
import Foundation

final class User {
    @ID(key: .id) var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "email") var email: String
    @Field(key: "password") var password: String
    @Field(key: "profileImageUrl") var profileImageUrl: String
    @Field(key: "token") private var _token: String
    var token: Token? {
        get {
            .init(from: _token)
        }
        set {
            _token = newValue?.encoded ?? .empty
        }
    }
    @Field(key: "sports") var sports: [SportType]
    @Field(key: "chats") var chats: [UUID]
    @Timestamp(key: "createdAt", on: .create, format: .iso8601) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update, format: .iso8601) var updatedAt: Date?

    init(id: UUID?, name: String, email: String, password: String, profileImageUrl: String, token: Token?, sports: [SportType], chats: [UUID]) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.profileImageUrl = profileImageUrl
        self.token = token
        self.sports = sports
        self.chats = chats
    }
}

extension User: PostgresModellable {
    static var schema: String {
        Constants.Schema.users.rawValue
    }

    convenience init() {
        self.init(id: .init(), name: .empty, email: .empty, password: .empty, profileImageUrl: .empty, token: nil, sports: .empty, chats: .empty)
    }

    convenience init(from dto: UserDTO) {
        self.init(id: dto.primaryId, name: dto.name, email: dto.email, password: .empty, profileImageUrl: dto.profileImageUrl ?? .empty, token: nil, sports: dto.sports.map(\.model), chats: dto.chats)
    }

    var dto: UserDTO {
        .init(primaryId: id ?? .init(), name: name, email: email, profileImageUrl: profileImageUrl, sports: .empty, chats: chats)
    }
}

extension User: Authenticatable { }
