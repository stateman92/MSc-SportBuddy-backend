//
//  GroupController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct GroupController { }

extension GroupController: GroupControllerProtocol {
    func groupGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupGetResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func groupPost(with req: Request, asAuthenticated user: User, groupId: UUID, message: String) throws -> EventLoopFuture<groupPostResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func groupPut(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID, modifiedMessage: UUID) throws -> EventLoopFuture<groupPutResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func groupDelete(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupDeleteResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
    func groupPatch(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupPatchResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
}
