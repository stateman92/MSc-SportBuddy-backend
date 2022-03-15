//
//  MockEmailService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct MockEmailService {
    init() { }
}

extension MockEmailService: EmailServiceProtocol {
    func setup(app: Application) { }

    func sendEmail(fromEmail: Email, replyTo: Email?, subject: String?, on request: Request) throws -> EventLoopFuture<Void> {
        request.eventLoop.makeSucceededVoidFuture()
    }
}
