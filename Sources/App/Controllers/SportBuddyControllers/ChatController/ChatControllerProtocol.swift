//
//  ChatControllerProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol ChatControllerProtocol {
    func chatGet(with req: Request, asAuthenticated user: User, chatId: UUID) throws -> EventLoopFuture<chatGetResponse>
    func chatPost(with req: Request, asAuthenticated user: User, chatId: UUID, message: String) throws -> EventLoopFuture<chatPostResponse>
    func chatPut(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID, modifiedMessage: UUID) throws -> EventLoopFuture<chatPutResponse>
    func chatDelete(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatDeleteResponse>
}
