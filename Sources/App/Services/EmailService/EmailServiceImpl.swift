//
//  EmailServiceImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import SendGrid
import Vapor

struct EmailServiceImpl {
    /// Initialize the object.
    init() { }
}

// MARK: - EmailService

extension EmailServiceImpl: EmailService {
    /// Setup the service.
    /// - Parameter app: the `Application` instance.
    func setup(app: Application) {
        app.sendgrid.initialize()
    }

    /// Send an email.
    /// - Parameter to: the target email.
    /// - Parameter fromEmail: the sending email.
    /// - Parameter subject: the subject of the email. By default `nil`.
    /// - Parameter text: the content of the email.
    /// - Parameter on: the request that the email will be sent on.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func sendEmail(to toEmail: String, fromEmail: String, subject: String? = nil, text: String, on req: Request) throws -> EventLoopFuture<Void> {
        let email = SendGridEmail(personalizations: [.init(to: [.init(email: toEmail)], subject: subject)],
                                  from: .init(email: fromEmail),
                                  subject: subject,
                                  content: [["type": "text/plain", "value": text], ["type": "text/html", "value": text]])

        return try req.application.sendgrid.client.send(email: email, on: req.eventLoop).flatMapError { error in
            if let sendgridError = error as? SendGridError {
                req.logger.error("\(sendgridError)")
            }
            return req.eventLoop.makeSucceededVoidFuture()
        }
    }
}
