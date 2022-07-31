//
//  ChatEntriesController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol ChatEntriesController {
    func chatEntriesGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<chatEntriesGetResponse>
    func chatEntriesPost(with req: Request, asAuthenticated user: User, chatId: UUID, message: String) throws -> EventLoopFuture<chatEntriesPostResponse>
    func chatEntriesPut(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<chatEntriesPutResponse>
    func chatEntriesDelete(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatEntriesDeleteResponse>
    func chatEntriesPatch(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatEntriesPatchResponse>
}
