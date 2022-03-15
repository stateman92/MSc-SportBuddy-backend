//
//  EmailService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import SendGrid
import Vapor

struct EmailService {
    init() { }
}

extension EmailService: EmailServiceProtocol {
    func setup(app: Application) {
        app.sendgrid.initialize()
    }

    func sendEmail(fromEmail: Email, replyTo: Email?, subject: String?, on request: Request) throws -> EventLoopFuture<Void> {
        let email = SendGridEmail(from: fromEmail.sendGridEmail,
                                  replyTo: replyTo?.sendGridEmail,
                                  subject: subject)

        return try request.application.sendgrid.client.send(email: email, on: request.eventLoop).flatMapError { error in
            if let sendgridError = error as? SendGridError {
                request.logger.error("\(sendgridError)")
            }
            return request.eventLoop.makeSucceededVoidFuture()
        }
    }
}
