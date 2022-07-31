//
//  GroupManagingController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol GroupManagingController {
    func groupManagingGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupManagingGetResponse>
    func groupManagingPost(with req: Request, asAuthenticated user: User, groupId: UUID) throws -> EventLoopFuture<groupManagingPostResponse>
    func groupManagingDelete(with req: Request, asAuthenticated user: User, groupId: UUID) throws -> EventLoopFuture<groupManagingDeleteResponse>
}
