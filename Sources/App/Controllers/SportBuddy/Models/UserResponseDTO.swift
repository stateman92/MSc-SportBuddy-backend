//
// UserResponseDTO.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: /Models.UserResponseDTO

import Vapor


public final class UserResponseDTO: Content {

    public var token: UUID
    public var user: UserDTO

    public init(token: UUID, user: UserDTO) { 
        self.token = token
        self.user = user
    }
}
