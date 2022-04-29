// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation

class EmailServiceProtocolMock: EmailServiceProtocol {

    //MARK: - setup

    var setupAppCallsCount = 0
    var setupAppCalled: Bool {
        return setupAppCallsCount > 0
    }
    var setupAppReceivedApp: Application?
    var setupAppReceivedInvocations: [Application] = []
    var setupAppClosure: ((Application) -> Void)?

    func setup(app: Application) {
        setupAppCallsCount += 1
        setupAppReceivedApp = app
        setupAppReceivedInvocations.append(app)
        setupAppClosure?(app)
    }

    //MARK: - sendEmail

    var sendEmailToFromEmailSubjectTextOnThrowableError: Error?
    var sendEmailToFromEmailSubjectTextOnCallsCount = 0
    var sendEmailToFromEmailSubjectTextOnCalled: Bool {
        return sendEmailToFromEmailSubjectTextOnCallsCount > 0
    }
    var sendEmailToFromEmailSubjectTextOnReceivedArguments: (toEmail: String, fromEmail: String, subject: String?, text: String, req: Request)?
    var sendEmailToFromEmailSubjectTextOnReceivedInvocations: [(toEmail: String, fromEmail: String, subject: String?, text: String, req: Request)] = []
    var sendEmailToFromEmailSubjectTextOnReturnValue: EventLoopFuture<Void>!
    var sendEmailToFromEmailSubjectTextOnClosure: ((String, String, String?, String, Request) throws -> EventLoopFuture<Void>)?

    func sendEmail(to toEmail: String, fromEmail: String, subject: String?, text: String, on req: Request) throws -> EventLoopFuture<Void> {
        if let error = sendEmailToFromEmailSubjectTextOnThrowableError {
            throw error
        }
        sendEmailToFromEmailSubjectTextOnCallsCount += 1
        sendEmailToFromEmailSubjectTextOnReceivedArguments = (toEmail: toEmail, fromEmail: fromEmail, subject: subject, text: text, req: req)
        sendEmailToFromEmailSubjectTextOnReceivedInvocations.append((toEmail: toEmail, fromEmail: fromEmail, subject: subject, text: text, req: req))
        return try sendEmailToFromEmailSubjectTextOnClosure.map({ try $0(toEmail, fromEmail, subject, text, req) }) ?? sendEmailToFromEmailSubjectTextOnReturnValue
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
