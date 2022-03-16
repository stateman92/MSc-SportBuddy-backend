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

    func sendEmail(to toEmail: String, fromEmail: String, subject: String?, text: String, on request: Request) throws -> EventLoopFuture<Void> {
        let email = SendGridEmail(personalizations: [.init(to: [.init(email: toEmail)], subject: subject)],
                                  from: .init(email: fromEmail),
                                  subject: subject,
                                  content: [["type": "text/plain", "value": text], ["type": "text/html", "value": text]])

        return try request.application.sendgrid.client.send(email: email, on: request.eventLoop).flatMapError { error in
            if let sendgridError = error as? SendGridError {
                request.logger.error("\(sendgridError)")
            }
            return request.eventLoop.makeSucceededVoidFuture()
        }
    }
}
