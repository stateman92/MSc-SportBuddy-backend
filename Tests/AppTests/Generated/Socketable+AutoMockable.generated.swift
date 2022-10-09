// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import App
import Foundation
import Vapor
import NIOCore
import NIOWebSocket

class SocketableMock: Socketable {
    var isClosed: Bool {
        get { return underlyingIsClosed }
        set(value) { underlyingIsClosed = value }
    }
    var underlyingIsClosed: Bool!

    //MARK: - close

    var closeCallsCount = 0
    var closeCalled: Bool {
        return closeCallsCount > 0
    }
    var closeClosure: (() -> Void)?

    func close() {
        closeCallsCount += 1
        closeClosure?()
    }

    //MARK: - send

    var sendCallsCount = 0
    var sendCalled: Bool {
        return sendCallsCount > 0
    }
    var sendReceivedText: String?
    var sendReceivedInvocations: [String] = []
    var sendClosure: ((String) -> Void)?

    func send(_ text: String) {
        sendCallsCount += 1
        sendReceivedText = text
        sendReceivedInvocations.append(text)
        sendClosure?(text)
    }

}
