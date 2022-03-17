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
        guard let userId = user.id else { return req.eventLoop.future(.http400) }
        return Chat
            .findOrAbort(chatId, on: req)
            .flatMap { chat in
                let id = UUID()
                let chatEntry = ChatEntry(id: id, message: message, timestamp: Date().secondsSince1970, sender: userId)
                chat.chatEntries.append(id)
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
                return $0.update(on: req, transformTo: .http200)
            }
    }

    func chatDelete(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatDeleteResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
}
