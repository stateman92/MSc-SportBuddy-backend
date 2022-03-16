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
        req.eventLoop.makeCompletedFuture(.success(.http200(SportType.allCases.map(\.dto))))
    }
    
    func groupManagingPost(with req: Request, asAuthenticated user: User, body: String) throws -> EventLoopFuture<groupManagingPostResponse> {
        guard let sportType = SportType(rawValue: body) else { return req.eventLoop.future(.http400) }
        return User
            .queryAll(on: req)
            .map { users -> EventLoopFuture<Void> in
                guard let user = users.first(where: { $0.id == user.id }) else { return req.eventLoop.future() }
                if !user.sports.contains(sportType) {
                    user.sports.append(sportType)
                    return user.update(on: req)
                }
                return req.eventLoop.future()
            }
            .transform(to: .http200)
    }

    func groupManagingDelete(with req: Request, asAuthenticated user: User, body: String) throws -> EventLoopFuture<groupManagingDeleteResponse> {
        guard let sportType = SportType(rawValue: body) else { return req.eventLoop.future(.http400) }
        return User
            .queryAll(on: req)
            .map { users -> EventLoopFuture<Void> in
                guard let user = users.first(where: { $0.id == user.id }) else { return req.eventLoop.future() }
                if user.sports.contains(sportType) {
                    user.sports = user.sports.filter { $0 != sportType }
                    return user.update(on: req)
                }
                return req.eventLoop.future()
            }
            .transform(to: .http200)
    }
}
