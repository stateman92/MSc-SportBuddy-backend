//
//  ChatController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct ChatController { }

extension ChatController: ChatControllerProtocol {
    func chatGet(with req: Request, asAuthenticated user: User, chatId: UUID) throws -> EventLoopFuture<chatGetResponse> {
        Chat
            .findOrAbort(chatId, on: req)
            .map { .http200([$0.dto]) }
    }

    func chatPost(with req: Request, asAuthenticated user: User, chatId: UUID, message: String) throws -> EventLoopFuture<chatPostResponse> {
        guard let id = user.id else { return req.eventLoop.future(.http400) }
        return Chat
            .findOrAbort(chatId, on: req)
            .flatMap { chat in
                let chatEntry = ChatEntry(id: .init(), message: message, timestamp: Date().secondsSince1970, sender: id)
                chat.chatEntries.append(chatEntry)
                return chatEntry
                    .create(on: req)
                    .flatMap { chat.update(on: req) }
                    .transform(to: .http200)
            }
    }

    func chatPut(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<chatPutResponse> {
        ChatEntry
            .findOrAbort(chatEntryDTOId, on: req)
            .flatMap {
                $0.message = modifiedMessage
                return $0.update(on: req)
            }
            .flatMap {
                Chat
                    .queryAll(on: req)
                    .map { chats in
                        guard let chat = chats.first(where: { $0.chatEntries.contains { $0.id == chatEntryDTOId } }) else { return .http200 }
                        chat.chatEntries.forEach { chatEntry in
                            if chatEntry.id == chatEntryDTOId {
                                chatEntry.message = modifiedMessage
                            }
                        }
                        return .http200
                    }
            }
    }

    func chatDelete(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatDeleteResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
}
