//
//  EmailServiceProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol EmailServiceProtocol: Initable {
    func setup(app: Application)
    func sendEmail(to toEmail: String, fromEmail: String, subject: String?, text: String, on request: Request) throws -> EventLoopFuture<Void>
}

extension EmailServiceProtocol {
    func sendEmail(to toEmail: String, fromEmail: String, subject: String? = nil, text: String, on request: Request) throws -> EventLoopFuture<Void> {
        try sendEmail(to: toEmail, fromEmail: fromEmail, subject: subject, text: text, on: request)
    }

    func sendPasswordRecoveryEmail(to toEmail: String, on request: Request) throws -> EventLoopFuture<Void> {
        try sendEmail(to: toEmail, fromEmail: "csakugy202@gmail.com", subject: "Forgotten password on SportBuddy!", text: "Your password is forgotten. :(", on: request)
    }
}
