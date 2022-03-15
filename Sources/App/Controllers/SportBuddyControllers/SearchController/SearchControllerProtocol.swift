//
//  SearchControllerProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol SearchControllerProtocol {
    func searchUserPost(with req: Request, name: String) throws -> EventLoopFuture<searchUserPostResponse>
}
