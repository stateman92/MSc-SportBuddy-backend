//
//  MockEmailService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct MockEmailService {
    /// Initialize the object.
    init() { }
}

// MARK: - EmailService

extension MockEmailService: EmailService {
    /// Setup the service.
    /// - Parameter app: the `Application` instance.
    func setup(app: Application) { }

    /// Send an email.
    /// - Parameter toEmail: the target email.
    /// - Parameter fromEmail: the sending email.
    /// - Parameter subject: the subject of the email. By default `nil`.
    /// - Parameter text: the content of the email.
    /// - Parameter req: the request that the email will be sent on.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func sendEmail(to toEmail: String, fromEmail: String, subject: String? = nil, text: String, on req: Request) throws -> EventLoopFuture<Void> {
        req.eventLoop.makeSucceededVoidFuture()
    }
}
