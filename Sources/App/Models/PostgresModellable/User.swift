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
    enum Keys: String {
        case name
        case email
        case password
        case profileImage
        case bio
        case isAdmin
        case token
        case chats
        case resetPasswordToken
        case createdAt
        case updatedAt
    }

    @ID(key: .id) var id: UUID?
    @Field(Keys.name) var name: String
    @Field(Keys.email) var email: String
    @Field(Keys.password) var password: String
    @Field(Keys.profileImage) var profileImage: String
    @Field(Keys.bio) var bio: String
    @Field(Keys.isAdmin) var isAdmin: Bool
    @Field(Keys.token) private var _token: String
    var token: Token? {
        get {
            Token(from: _token)
        }
        set {
            _token = newValue?.encoded ?? .init()
        }
    }
    @Field(Keys.chats) var chats: [UUID]
    @Field(Keys.resetPasswordToken) private var _resetPasswordToken: String
    var resetPasswordToken: Token? {
        get {
            Token(from: _resetPasswordToken)
        }
        set {
            _resetPasswordToken = newValue?.encoded ?? .init()
        }
    }
    @Timestamp(Keys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(Keys.updatedAt, on: .update) var updatedAt: Date?

    /// Initialize an object.
    /// - Parameter id: the identifier.
    /// - Parameter name: the name of the user.
    /// - Parameter email: the email of the user.
    /// - Parameter password: the (hashed) password of the user.
    /// - Parameter profileImage: the profile image of the user.
    /// - Parameter bio: the bio of the user.
    /// - Parameter isAdmin: whether the user is admin.
    /// - Parameter token: the token of the user.
    /// - Parameter chats: the chats which the user participants in.
    /// - Parameter resetPasswordToken: the reset token of the user.
    init(id: UUID?, name: String, email: String, password: String, profileImage: String, bio: String, isAdmin: Bool, token: Token?, chats: [UUID], resetPasswordToken: Token?) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.profileImage = profileImage
        self.bio = bio
        self.isAdmin = isAdmin
        self.token = token
        self.chats = chats
        self.resetPasswordToken = resetPasswordToken
    }
}

extension User: PostgresModellable {
    /// The schema of the class.
    static var schema: String {
        Constants.Schema.users.rawValue
    }

    /// Initialize an empty object for a new record in the schema.
    convenience init() {
        self.init(id: .init(), name: .init(), email: .init(), password: .init(), profileImage: .init(), bio: .init(), isAdmin: false, token: nil, chats: .init(), resetPasswordToken: nil)
    }

    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    convenience init(from dto: UserDTO) {
        self.init(id: dto.primaryId, name: dto.name, email: dto.email, password: .init(), profileImage: dto.profileImage ?? .init(), bio: dto.bio ?? .init(), isAdmin: false, token: nil, chats: dto.chats, resetPasswordToken: nil)
    }

    /// Get the object as a DTO object.
    var dto: UserDTO {
        .init(primaryId: id ?? .init(), name: name, email: email, profileImage: profileImage, bio: bio, chats: chats)
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
