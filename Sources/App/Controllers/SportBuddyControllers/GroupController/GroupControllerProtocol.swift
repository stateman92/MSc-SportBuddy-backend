//
//  GroupControllerProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol GroupControllerProtocol {
    func groupGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupGetResponse>
    func groupPost(with req: Request, asAuthenticated user: User, groupId: UUID, message: String) throws -> EventLoopFuture<groupPostResponse>
    func groupPut(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID, modifiedMessage: UUID) throws -> EventLoopFuture<groupPutResponse>
    func groupDelete(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupDeleteResponse>
    func groupPatch(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupPatchResponse>
}
