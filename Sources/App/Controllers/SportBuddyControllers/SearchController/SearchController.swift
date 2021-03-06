//
//  SearchController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct SearchController { }

extension SearchController: SearchControllerProtocol {
    func searchUserPost(with req: Request, asAuthenticated user: User, name: String) throws -> EventLoopFuture<searchUserPostResponse> {
        req
            .repositories
            .users
            .queryAll()
            .map { .http200($0.filter { $0.name.localizedStandardContains(name) && $0.id != user.id }.map(\.dto)) }
    }
}
