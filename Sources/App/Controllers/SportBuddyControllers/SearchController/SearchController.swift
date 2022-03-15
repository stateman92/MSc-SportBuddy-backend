//
//  SearchController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct SearchController { }

extension SearchController: SearchControllerProtocol {
    func searchUserPost(with req: Request, name: String) throws -> EventLoopFuture<searchUserPostResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
}
