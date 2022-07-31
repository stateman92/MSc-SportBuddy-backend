//
//  ChatControllerImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 22..
//

import Vapor

struct ChatControllerImpl { }

// MARK: - ChatController

extension ChatControllerImpl: ChatController {
    func chatPut(with req: Request, asAuthenticated user: User, chatId: UUID, body: String?, users: [UUID]?) throws -> EventLoopFuture<chatPutResponse> {
        req
            .repositories
            .chats
            .findOrAbortAndModifyThenTransform(chatId, modify: { chat in
                chat.image = body ?? chat.image
                chat.users = users ?? chat.users
            }, transformTo: .http200)
    }
}
