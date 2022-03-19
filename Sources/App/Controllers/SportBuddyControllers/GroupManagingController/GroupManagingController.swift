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
        Group
            .queryAll(on: req)
            .map { .http200($0.map(\.dto)) }
    }
    
    func groupManagingPost(with req: Request, asAuthenticated user: User, groupId: UUID) throws -> EventLoopFuture<groupManagingPostResponse> {
        User
            .queryAll(on: req)
            .map { users -> EventLoopFuture<Void> in
                guard let user = users.first(where: { $0.id == user.id }) else { return req.eventLoop.future() }
                if !user.groups.contains(groupId) {
                    user.groups.append(groupId)
                    return user.update(on: req)
                }
                return req.eventLoop.future()
            }
            .transform(to: .http200)
    }

    func groupManagingDelete(with req: Request, asAuthenticated user: User, groupId: UUID) throws -> EventLoopFuture<groupManagingDeleteResponse> {
        User
            .queryAll(on: req)
            .map { users -> EventLoopFuture<Void> in
                guard let user = users.first(where: { $0.id == user.id }) else { return req.eventLoop.future() }
                if user.groups.contains(groupId) {
                    user.groups = user.groups.filter { $0 != groupId }
                    return user.update(on: req)
                }
                return req.eventLoop.future()
            }
            .transform(to: .http200)
    }
}
