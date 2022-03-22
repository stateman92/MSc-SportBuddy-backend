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
    @Field(key: "profileImage") var profileImage: String
    @Field(key: "bio") var bio: String
    @Field(key: "token") private var _token: String
    var token: Token? {
        get {
            Token(from: _token)
        }
        set {
            _token = newValue?.encoded ?? .empty
        }
    }
    @Field(key: "chats") var chats: [UUID]
    @Field(key: "groups") var groups: [UUID]
    @Timestamp(key: "createdAt", on: .create, format: .iso8601) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update, format: .iso8601) var updatedAt: Date?

    init(id: UUID?, name: String, email: String, password: String, profileImage: String, bio: String, token: Token?, chats: [UUID], groups: [UUID]) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.profileImage = profileImage
        self.bio = bio
        self.token = token
        self.chats = chats
        self.groups = groups
    }
}

extension User: PostgresModellable {
    static var schema: String {
        Constants.Schema.users.rawValue
    }

    convenience init() {
        self.init(id: .init(), name: .empty, email: .empty, password: .empty, profileImage: .empty, bio: .empty, token: nil, chats: .empty, groups: .empty)
    }

    convenience init(from dto: UserDTO) {
        self.init(id: dto.primaryId, name: dto.name, email: dto.email, password: .empty, profileImage: dto.profileImage ?? .empty, bio: dto.bio ?? .empty, token: nil, chats: dto.chats, groups: dto.groups)
    }

    var dto: UserDTO {
        .init(primaryId: id ?? .init(), name: name, email: email, profileImage: profileImage, bio: bio, chats: chats, groups: groups)
    }
}

extension User: Authenticatable { }
