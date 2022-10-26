//
//  EmailService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

/// A protocol for sending emails.
protocol EmailService: Initable, AutoMockable {
    /// Setup the service.
    /// - Parameter app: the `Application` instance.
    func setup(app: Application)

    /// Send an email.
    /// - Parameter toEmail: the target email.
    /// - Parameter subject: the subject of the email.
    /// - Parameter text: the content of the email.
    /// - Parameter req: the request that the email will be sent on.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func sendEmail(to toEmail: String, subject: String?, text: String, on req: Request) throws -> EventLoopFuture<Void>
}

extension EmailService {
    /// Send an email.
    /// - Parameter toEmail: the target email.
    /// - Parameter subject: the subject of the email. By default `nil`.
    /// - Parameter text: the content of the email.
    /// - Parameter req: the request that the email will be sent on.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func sendEmail(to toEmail: String, subject: String? = nil, text: String, on req: Request) throws -> EventLoopFuture<Void> {
        try sendEmail(to: toEmail, subject: subject, text: text, on: req)
    }

    /// Send an recovery email.
    /// - Parameter name: the target name.
    /// - Parameter email: the target email.
    /// - Parameter id: the id of the request.
    /// - Parameter req: the request that the email will be sent on.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func sendPasswordRecoveryEmail(to name: String, email: String, id: UUID, on req: Request) throws -> EventLoopFuture<Void> {
        let content = Constants.forgotPasswordEmail(name: name, email: email, token: id.uuidString)
        return try sendEmail(to: email, subject: content.subject, text: content.text, on: req)
    }
}
