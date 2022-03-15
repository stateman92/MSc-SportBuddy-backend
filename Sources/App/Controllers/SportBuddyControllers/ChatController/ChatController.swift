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
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func chatPost(with req: Request, asAuthenticated user: User, chatId: UUID, message: String) throws -> EventLoopFuture<chatPostResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func chatPut(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID, modifiedMessage: UUID) throws -> EventLoopFuture<chatPutResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func chatDelete(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatDeleteResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
}
