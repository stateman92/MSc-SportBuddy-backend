//
//  GroupController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 22..
//

import Vapor

struct GroupController { }

extension GroupController: GroupControllerProtocol {
    func groupPut(with req: Request, asAuthenticated user: User, groupId: UUID, body: String?, users: [UUID]?) throws -> EventLoopFuture<groupPutResponse> {
        req
            .repositories
            .groups
            .findOrAbortAndModifyThenTransform(groupId, modify: { group in
                group.image = body ?? group.image
                group.users = users ?? group.users
            }, transformTo: .http200)
    }
}
