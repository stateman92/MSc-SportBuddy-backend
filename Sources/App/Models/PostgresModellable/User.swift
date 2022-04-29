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
            _token = newValue?.encoded ?? .init()
        }
    }
    @Field(key: "chats") var chats: [UUID]
    @Field(key: "groups") var groups: [UUID]
    @Timestamp(key: "createdAt", on: .create, format: .iso8601) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update, format: .iso8601) var updatedAt: Date?

    /// Initialize an object.
    /// - Parameter id: the identifier.
    /// - Parameter name: the name of the user.
    /// - Parameter email: the email of the user.
    /// - Parameter password: the (hashed) password of the user.
    /// - Parameter profileImage: the profile image of the user.
    /// - Parameter bio: the bio of the user.
    /// - Parameter token: the token of the user.
    /// - Parameter chats: the chats which the user participants in.
    /// - Parameter groups: the groups which the user participants in.
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
    /// The schema of the class.
    static var schema: String {
        Constants.Schema.users.rawValue
    }

    /// Initialize an empty object for a new record in the schema.
    convenience init() {
        self.init(id: .init(), name: .init(), email: .init(), password: .init(), profileImage: .init(), bio: .init(), token: nil, chats: .init(), groups: .init())
    }

    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    convenience init(from dto: UserDTO) {
        self.init(id: dto.primaryId, name: dto.name, email: dto.email, password: .init(), profileImage: dto.profileImage ?? .init(), bio: dto.bio ?? .init(), token: nil, chats: dto.chats, groups: dto.groups)
    }

    /// Get the object as a DTO object.
    var dto: UserDTO {
        .init(primaryId: id ?? .init(), name: name, email: email, profileImage: profileImage, bio: bio, chats: chats, groups: groups)
    }
}

extension UserDTO {
    /// Get the DTO object as an object.
    var model: User {
        .init(from: self)
    }
}

/// Use the `User` as a class that holds data of the auth.
extension User: Authenticatable { }
