//
//  GroupEntriesControllerProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol GroupEntriesControllerProtocol {
    func groupEntriesGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupEntriesGetResponse>
    func groupEntriesPost(with req: Request, asAuthenticated user: User, groupId: UUID, message: String) throws -> EventLoopFuture<groupEntriesPostResponse>
    func groupEntriesPut(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<groupEntriesPutResponse>
    func groupEntriesDelete(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupEntriesDeleteResponse>
    func groupEntriesPatch(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupEntriesPatchResponse>
}
