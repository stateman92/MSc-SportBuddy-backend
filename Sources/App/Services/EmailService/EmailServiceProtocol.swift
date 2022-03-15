//
//  EmailServiceProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol EmailServiceProtocol {
    init()
    func setup(app: Application)
    func sendEmail(fromEmail: Email, replyTo: Email?, subject: String?, on request: Request) throws -> EventLoopFuture<Void>
}

extension EmailServiceProtocol {
    func sendEmail(fromEmail: Email, replyTo: Email? = nil, subject: String? = nil, on request: Request) throws -> EventLoopFuture<Void> {
        try sendEmail(fromEmail: fromEmail, replyTo: replyTo, subject: subject, on: request)
    }
}
