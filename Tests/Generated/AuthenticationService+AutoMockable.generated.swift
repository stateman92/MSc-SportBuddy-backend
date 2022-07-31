// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation

class AuthenticationServiceMock: AuthenticationService {

    //MARK: - hash

    var hashPasswordCallsCount = 0
    var hashPasswordCalled: Bool {
        return hashPasswordCallsCount > 0
    }
    var hashPasswordReceivedPassword: String?
    var hashPasswordReceivedInvocations: [String?] = []
    var hashPasswordReturnValue: String?
    var hashPasswordClosure: ((String?) -> String?)?

    func hash(password: String?) -> String? {
        hashPasswordCallsCount += 1
        hashPasswordReceivedPassword = password
        hashPasswordReceivedInvocations.append(password)
        return hashPasswordClosure.map({ $0(password) }) ?? hashPasswordReturnValue
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
