//
//  MailGunEmailServiceImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 26..
//

import Mailgun
import Vapor

/// A struct for sending emails.
struct MailGunEmailServiceImpl { }

// MARK: - EmailService

extension MailGunEmailServiceImpl: EmailService {
    /// Setup the service.
    /// - Parameter app: the `Application` instance.
    func setup(app: Application) {
        app.mailgun.configuration = .environment
        app.mailgun.defaultDomain = .init(Environment.get(.mailgunDomain), .us)
    }

    /// Send an email.
    /// - Parameter to: the target email.
    /// - Parameter subject: the subject of the email. By default `nil`.
    /// - Parameter text: the content of the email.
    /// - Parameter on: the request that the email will be sent on.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func sendEmail(to toEmail: String, subject: String? = nil, text: String, on req: Request) throws -> EventLoopFuture<Void> {
        req
            .mailgun()
            .send(.init(from: Environment.get(.mailgunEmail),
                        to: toEmail,
                        replyTo: Environment.get(.replyEmail),
                        bcc: Environment.get(.replyEmail),
                        subject: subject ?? .init(),
                        text: .init(),
                        html: text))
            .map { _ in () }
    }
}
