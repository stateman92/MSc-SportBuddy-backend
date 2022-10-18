// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import App
import Foundation
import Vapor
import NIOCore
import NIOWebSocket

class AuthenticationServiceMock: AuthenticationService {

    //MARK: - forceHash

    var forceHashPasswordCallsCount = 0
    var forceHashPasswordCalled: Bool {
        return forceHashPasswordCallsCount > 0
    }
    var forceHashPasswordReceivedPassword: String?
    var forceHashPasswordReceivedInvocations: [String?] = []
    var forceHashPasswordReturnValue: String?
    var forceHashPasswordClosure: ((String?) -> String?)?

    func forceHash(password: String?) -> String? {
        forceHashPasswordCallsCount += 1
        forceHashPasswordReceivedPassword = password
        forceHashPasswordReceivedInvocations.append(password)
        return forceHashPasswordClosure.map({ $0(password) }) ?? forceHashPasswordReturnValue
    }

    //MARK: - isValid

    var isValidPasswordHashedPasswordCallsCount = 0
    var isValidPasswordHashedPasswordCalled: Bool {
        return isValidPasswordHashedPasswordCallsCount > 0
    }
    var isValidPasswordHashedPasswordReceivedArguments: (password: String?, hashedPassword: String)?
    var isValidPasswordHashedPasswordReceivedInvocations: [(password: String?, hashedPassword: String)] = []
    var isValidPasswordHashedPasswordReturnValue: Bool!
    var isValidPasswordHashedPasswordClosure: ((String?, String) -> Bool)?

    func isValid(password: String?, hashedPassword: String) -> Bool {
        isValidPasswordHashedPasswordCallsCount += 1
        isValidPasswordHashedPasswordReceivedArguments = (password: password, hashedPassword: hashedPassword)
        isValidPasswordHashedPasswordReceivedInvocations.append((password: password, hashedPassword: hashedPassword))
        return isValidPasswordHashedPasswordClosure.map({ $0(password, hashedPassword) }) ?? isValidPasswordHashedPasswordReturnValue
    }

    //MARK: - isValid

    var isValidEmailCallsCount = 0
    var isValidEmailCalled: Bool {
        return isValidEmailCallsCount > 0
    }
    var isValidEmailReceivedEmail: String?
    var isValidEmailReceivedInvocations: [String] = []
    var isValidEmailReturnValue: Bool!
    var isValidEmailClosure: ((String) -> Bool)?

    func isValid(email: String) -> Bool {
        isValidEmailCallsCount += 1
        isValidEmailReceivedEmail = email
        isValidEmailReceivedInvocations.append(email)
        return isValidEmailClosure.map({ $0(email) }) ?? isValidEmailReturnValue
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
