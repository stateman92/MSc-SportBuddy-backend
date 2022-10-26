// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import App
import Foundation
import Vapor
import NIOCore
import NIOWebSocket

class EmailServiceMock: EmailService {

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

    var sendEmailToSubjectTextOnThrowableError: Error?
    var sendEmailToSubjectTextOnCallsCount = 0
    var sendEmailToSubjectTextOnCalled: Bool {
        return sendEmailToSubjectTextOnCallsCount > 0
    }
    var sendEmailToSubjectTextOnReceivedArguments: (toEmail: String, subject: String?, text: String, req: Request)?
    var sendEmailToSubjectTextOnReceivedInvocations: [(toEmail: String, subject: String?, text: String, req: Request)] = []
    var sendEmailToSubjectTextOnReturnValue: EventLoopFuture<Void>!
    var sendEmailToSubjectTextOnClosure: ((String, String?, String, Request) throws -> EventLoopFuture<Void>)?

    func sendEmail(to toEmail: String, subject: String?, text: String, on req: Request) throws -> EventLoopFuture<Void> {
        if let error = sendEmailToSubjectTextOnThrowableError {
            throw error
        }
        sendEmailToSubjectTextOnCallsCount += 1
        sendEmailToSubjectTextOnReceivedArguments = (toEmail: toEmail, subject: subject, text: text, req: req)
        sendEmailToSubjectTextOnReceivedInvocations.append((toEmail: toEmail, subject: subject, text: text, req: req))
        return try sendEmailToSubjectTextOnClosure.map({ try $0(toEmail, subject, text, req) }) ?? sendEmailToSubjectTextOnReturnValue
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
