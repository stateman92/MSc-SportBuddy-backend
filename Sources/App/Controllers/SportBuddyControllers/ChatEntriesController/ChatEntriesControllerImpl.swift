//
//  ChatEntriesControllerImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct ChatEntriesControllerImpl { }

// MARK: - ChatEntriesController

extension ChatEntriesControllerImpl: ChatEntriesController {
    func chatEntriesGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<chatEntriesGetResponse> {
        getChats(of: user, on: req)
            .flatMap {
                $0
                    .map { getChatDTO(from: $0, otherParty: $0.users.first { $0 != user.id }!, on: req) }
                    .flatten(on: req)
            }
            .map { .http200($0) }
    }

    func chatEntriesPost(with req: Request, asAuthenticated user: User, chatId: UUID, message: String) throws -> EventLoopFuture<chatEntriesPostResponse> {
        guard let userId = user.id else { return req.eventLoop.future(.http400) }
        return req
            .repositories
            .chats
            .findOrAbort(chatId)
            .flatMap { chat in
                let id = UUID()
                let chatEntry = ChatEntry(id: id, message: message, timestamp: Date().secondsSince1970, sender: userId, deleted: false)
                chat.chatEntries.append(id)
                return req
                    .repositories
                    .chatEntries
                    .create(chatEntry)
                    .flatMap { req.repositories.chats.update(chat) }
                    .transform(to: .http200)
            }
    }

    func chatEntriesPut(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<chatEntriesPutResponse> {
        req
            .repositories
            .chatEntries
            .findOrAbortAndModifyThenTransform(chatEntryDTOId, modify: { chatEntry in
                chatEntry.message = modifiedMessage
            }, transformTo: .http200)
    }

    func chatEntriesDelete(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatEntriesDeleteResponse> {
        deleteOrUndelete(delete: true, chatEntryDTOId: chatEntryDTOId, on: req, transformTo: .http200)
    }

    func chatEntriesPatch(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatEntriesPatchResponse> {
        deleteOrUndelete(delete: false, chatEntryDTOId: chatEntryDTOId, on: req, transformTo: .http200)
    }
}

// MARK: - Helpers

extension ChatEntriesControllerImpl {
    private func getChatEntries(for ids: [UUID], on req: Request) -> EventLoopFuture<[ChatEntry]> {
        ids
            .map { req.repositories.chatEntries.findOrAbort($0) }
            .flatten(on: req)
    }

    private func getChats(of user: User, on req: Request) -> EventLoopFuture<[Chat]> {
        user
            .chats
            .map { req.repositories.chats.findOrAbort($0) }
            .flatten(on: req)
    }

    private func getChatDTO(from chat: Chat, otherParty: UUID, on req: Request) -> EventLoopFuture<ChatDTO> {
        getChatEntries(for: chat.chatEntries, on: req)
            .map { $0.map(\.dto) }
            .flatMap { entries in
                req.repositories.users.findOrAbort(otherParty).map(\.name).map {
                    (entries, $0)
                }
            }
            .map { chat.dto(with: $0.0, otherParty: $0.1) }
    }

    private func deleteOrUndelete<NewValue>(delete: Bool, chatEntryDTOId: UUID, on req: Request, transformTo: NewValue) -> EventLoopFuture<NewValue> {
        req
            .repositories
            .chatEntries
            .findOrAbortAndModifyThenTransform(chatEntryDTOId, modify: {
                $0.deleted = delete
            }, transformTo: transformTo)
    }
}
