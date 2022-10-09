// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import App
import Foundation
import Vapor
import NIOCore
import NIOWebSocket

class AuthorizationServiceMock: AuthorizationService {

    //MARK: - auth

    var authTokenReqCallsCount = 0
    var authTokenReqCalled: Bool {
        return authTokenReqCallsCount > 0
    }
    var authTokenReqReceivedArguments: (token: String, req: Request)?
    var authTokenReqReceivedInvocations: [(token: String, req: Request)] = []
    var authTokenReqReturnValue: EventLoopFuture<Void>!
    var authTokenReqClosure: ((String, Request) -> EventLoopFuture<Void>)?

    func auth(token: String, req: Request) -> EventLoopFuture<Void> {
        authTokenReqCallsCount += 1
        authTokenReqReceivedArguments = (token: token, req: req)
        authTokenReqReceivedInvocations.append((token: token, req: req))
        return authTokenReqClosure.map({ $0(token, req) }) ?? authTokenReqReturnValue
    }

    //MARK: - authType

    var authTypeCallsCount = 0
    var authTypeCalled: Bool {
        return authTypeCallsCount > 0
    }
    var authTypeReturnValue: User.Type!
    var authTypeClosure: (() -> User.Type)?

    func authType() -> User.Type {
        authTypeCallsCount += 1
        return authTypeClosure.map({ $0() }) ?? authTypeReturnValue
    }

    //MARK: - init

    var initClosure: (() -> Void)?

    required init() {
        initClosure?()
    }
}
