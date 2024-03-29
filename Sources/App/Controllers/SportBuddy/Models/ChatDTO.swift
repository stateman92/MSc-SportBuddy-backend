//
// ChatDTO.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: /Models.ChatDTO

import Vapor


public final class ChatDTO: Content {

    public var chatEntries: [ChatEntryDTO]
    public var image: String
    public var primaryId: UUID
    public var users: [UUID]
    public var otherParty: String

    public init(chatEntries: [ChatEntryDTO], image: String, primaryId: UUID, users: [UUID], otherParty: String) { 
        self.chatEntries = chatEntries
        self.image = image
        self.primaryId = primaryId
        self.users = users
        self.otherParty = otherParty
    }
}
