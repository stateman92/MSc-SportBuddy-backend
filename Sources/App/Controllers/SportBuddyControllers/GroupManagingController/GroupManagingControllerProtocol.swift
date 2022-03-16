//
//  GroupManagingControllerProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol GroupManagingControllerProtocol {
    func groupManagingGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupManagingGetResponse>
    func groupManagingPost(with req: Request, asAuthenticated user: User, body: String) throws -> EventLoopFuture<groupManagingPostResponse>
    func groupManagingDelete(with req: Request, asAuthenticated user: User, body: String) throws -> EventLoopFuture<groupManagingDeleteResponse>
}
