//
//  GroupControllerProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 22..
//

import Vapor

protocol GroupControllerProtocol {
    func groupPut(with req: Request, asAuthenticated user: User, groupId: UUID, body: String?, users: [UUID]?) throws -> EventLoopFuture<groupPutResponse>
}
