//
//  UserController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol UserController {
    func registerPost(with req: Request, name: String, email: String, password: String) throws -> EventLoopFuture<registerPostResponse>
    func loginPost(with req: Request, email: String, password: String) throws -> EventLoopFuture<loginPostResponse>
    func forgotPasswordPost(with req: Request, email: String) throws -> EventLoopFuture<forgotPasswordPostResponse>
    func logoutPost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<logoutPostResponse>
    func imagePost(with req: Request, asAuthenticated user: User, body: String?) throws -> EventLoopFuture<imagePostResponse>
    func userImageGet(with req: Request, asAuthenticated user: User, chatId: String) throws -> EventLoopFuture<userImageGetResponse>
}
