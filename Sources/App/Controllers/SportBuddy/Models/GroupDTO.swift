//
// GroupDTO.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: /Models.GroupDTO

import Vapor


public final class GroupDTO: Content {

    public var primaryId: UUID
    public var sportType: SportTypeDTO
    public var users: [UUID]
    public var groupEntries: [GroupEntryDTO]
    public var image: String

    public init(primaryId: UUID, sportType: SportTypeDTO, users: [UUID], groupEntries: [GroupEntryDTO], image: String) { 
        self.primaryId = primaryId
        self.sportType = sportType
        self.users = users
        self.groupEntries = groupEntries
        self.image = image
    }
}
