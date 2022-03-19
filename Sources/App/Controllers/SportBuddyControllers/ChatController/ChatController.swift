//
//  ChatController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct ChatController { }

extension ChatController: ChatControllerProtocol {
    func chatGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<chatGetResponse> {
        getChats(of: user, on: req)
            .flatMap {
                $0
                    .map { getChatDTO(from: $0, on: req) }
                    .flatten(on: req)
            }
            .map { .http200($0) }
    }

    func chatPost(with req: Request, asAuthenticated user: User, chatId: UUID, message: String) throws -> EventLoopFuture<chatPostResponse> {
        guard let userId = user.id else { return req.eventLoop.future(.http400) }
        return Chat
            .findOrAbort(chatId, on: req)
            .flatMap { chat in
                let id = UUID()
                let chatEntry = ChatEntry(id: id, message: message, timestamp: Date().secondsSince1970, sender: userId, deleted: false)
                chat.chatEntries.append(id)
                return chatEntry
                    .create(on: req)
                    .flatMap { chat.update(on: req) }
                    .transform(to: .http200)
            }
    }

    func chatPut(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<chatPutResponse> {
        ChatEntry
            .findOrAbortAndModifyThenTransform(chatEntryDTOId, on: req, modify: { chatEntry in
                chatEntry.message = modifiedMessage
            }, transformTo: .http200)
    }

    func chatDelete(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatDeleteResponse> {
        deleteOrUndelete(delete: true, chatEntryDTOId: chatEntryDTOId, on: req, transformTo: .http200)
    }

    func chatPatch(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatPatchResponse> {
        deleteOrUndelete(delete: false, chatEntryDTOId: chatEntryDTOId, on: req, transformTo: .http200)
    }
}

extension ChatController {
    private func getChatEntries(for ids: [UUID], on request: Request) -> EventLoopFuture<[ChatEntry]> {
        ids
            .map { ChatEntry.findOrAbort($0, on: request) }
            .flatten(on: request.eventLoop)
    }

    private func getChats(of user: User, on request: Request) -> EventLoopFuture<[Chat]> {
        user
            .chats
            .map { Chat.findOrAbort($0, on: request) }
            .flatten(on: request.eventLoop)
    }

    private func getChatDTO(from chat: Chat, on request: Request) -> EventLoopFuture<ChatDTO> {
        getChatEntries(for: chat.chatEntries, on: request)
            .map { $0.map(\.dto) }
            .map { chat.dto(with: $0) }
    }

    private func deleteOrUndelete<NewValue>(delete: Bool, chatEntryDTOId: UUID, on request: Request, transformTo: NewValue) -> EventLoopFuture<NewValue> {
        ChatEntry
            .find(chatEntryDTOId, on: request)
            .unwrapOrAbort()
            .flatMap {
                $0.deleted = delete
                return $0.update(on: request, transformTo: transformTo)
            }
    }
}
