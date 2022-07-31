//
//  SearchController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol SearchController {
    func searchUserPost(with req: Request, asAuthenticated user: User, name: String) throws -> EventLoopFuture<searchUserPostResponse>
}
