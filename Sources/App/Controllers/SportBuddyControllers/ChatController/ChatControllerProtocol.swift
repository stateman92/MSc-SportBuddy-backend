//
//  ChatControllerProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 22..
//

import Vapor

protocol ChatControllerProtocol {
    func chatPut(with req: Request, asAuthenticated user: User, chatId: UUID, body: String?, users: [UUID]?) throws -> EventLoopFuture<chatPutResponse>
}
