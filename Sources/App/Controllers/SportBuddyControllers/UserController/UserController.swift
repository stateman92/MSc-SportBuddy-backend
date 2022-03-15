//
//  UserController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct UserController { }

extension UserController: UserControllerProtocol {
    func registerPost(with req: Request, name: String, email: String, password: String) throws -> EventLoopFuture<registerPostResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func loginPost(with req: Request, email: String, password: String) throws -> EventLoopFuture<loginPostResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func forgotPasswordPost(with req: Request, email: String) throws -> EventLoopFuture<forgotPasswordPostResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func logoutPost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<logoutPostResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
}
