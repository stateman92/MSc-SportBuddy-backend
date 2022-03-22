//
//  EmailServiceProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

/// A common protocol for the service that is capable of email sending.
protocol EmailServiceProtocol: Initable {
    /// Setup the service.
    /// - Parameter app: the `Application` instance.
    func setup(app: Application)

    /// Send an email.
    /// - Parameter toEmail: the target email.
    /// - Parameter fromEmail: the sending email.
    /// - Parameter subject: the subject of the email.
    /// - Parameter text: the content of the email.
    /// - Parameter req: the request that the email will be sent on.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func sendEmail(to toEmail: String, fromEmail: String, subject: String?, text: String, on req: Request) throws -> EventLoopFuture<Void>
}

extension EmailServiceProtocol {
    /// Send an email.
    /// - Parameter toEmail: the target email.
    /// - Parameter fromEmail: the sending email.
    /// - Parameter subject: the subject of the email. By default `nil`.
    /// - Parameter text: the content of the email.
    /// - Parameter req: the request that the email will be sent on.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func sendEmail(to toEmail: String, fromEmail: String, subject: String? = nil, text: String, on req: Request) throws -> EventLoopFuture<Void> {
        try sendEmail(to: toEmail, fromEmail: fromEmail, subject: subject, text: text, on: req)
    }

    /// Send an recovery email.
    /// - Parameter toEmail: the target email.
    /// - Parameter req: the request that the email will be sent on.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func sendPasswordRecoveryEmail(to toEmail: String, on req: Request) throws -> EventLoopFuture<Void> {
        try sendEmail(to: toEmail, fromEmail: "csakugy202@gmail.com", subject: "Forgotten password on SportBuddy!", text: "Your password is forgotten. :(", on: req)
    }
}
