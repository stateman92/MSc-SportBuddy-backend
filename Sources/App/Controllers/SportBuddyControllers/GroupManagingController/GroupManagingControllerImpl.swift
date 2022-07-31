//
//  GroupManagingControllerImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct GroupManagingControllerImpl { }

// MARK: - GroupManagingController

extension GroupManagingControllerImpl: GroupManagingController {
    func groupManagingGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupManagingGetResponse> {
        req
            .repositories
            .groups
            .queryAll()
            .map { .http200($0.map(\.dto)) }
    }
    
    func groupManagingPost(with req: Request, asAuthenticated user: User, groupId: UUID) throws -> EventLoopFuture<groupManagingPostResponse> {
        req
            .repositories
            .users
            .queryAll()
            .map { users -> EventLoopFuture<Void> in
                guard let user = users.first(where: { $0.id == user.id }) else { return req.eventLoop.future() }
                if !user.groups.contains(groupId) {
                    user.groups.append(groupId)
                    return req.repositories.users.update(user)
                }
                return req.eventLoop.future()
            }
            .transform(to: .http200)
    }

    func groupManagingDelete(with req: Request, asAuthenticated user: User, groupId: UUID) throws -> EventLoopFuture<groupManagingDeleteResponse> {
        req
            .repositories
            .users
            .queryAll()
            .map { users -> EventLoopFuture<Void> in
                guard let user = users.first(where: { $0.id == user.id }) else { return req.eventLoop.future() }
                if user.groups.contains(groupId) {
                    user.groups = user.groups.filter { $0 != groupId }
                    return req.repositories.users.update(user)
                }
                return req.eventLoop.future()
            }
            .transform(to: .http200)
    }
}
