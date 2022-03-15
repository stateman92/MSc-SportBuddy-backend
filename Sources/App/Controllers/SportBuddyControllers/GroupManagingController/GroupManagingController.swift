//
//  GroupManagingController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct GroupManagingController { }

extension GroupManagingController: GroupManagingControllerProtocol {
    func groupManagingGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupManagingGetResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
    
    func groupManagingPost(with req: Request, asAuthenticated user: User, groupId: UUID) throws -> EventLoopFuture<groupManagingPostResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func groupManagingDelete(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupManagingDeleteResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
}
