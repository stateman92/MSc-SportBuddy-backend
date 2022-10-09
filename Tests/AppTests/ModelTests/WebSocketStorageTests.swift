//
//  WebSocketStorageTests.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

@testable import App
import XCTest
import Vapor

final class WebSocketStorageTests: BaseTestCase {
    // MARK: Properties

    private let storage = WebSocketStorage(eventLoop: MockEventLoop())
}

// MARK: - Tests

extension WebSocketStorageTests {
    func testStorageFind() {
        // Given

        let id = UUID()
        storage.add(.init(id: id, socket: SocketableMock()))

        // When

        let client = storage.find(id)

        // Then

        XCTAssert(client != nil, "Client with given id must be found!")
    }

    func testStorageRemoveAndFind() {
        // Given

        let id = UUID()
        storage.add(.init(id: id, socket: SocketableMock()))
        storage.remove(id)

        // When

        let client = storage.find(id)

        // Then

        XCTAssert(client == nil, "Client with given id must be removed and therefore not be found!")
    }

    func testStorageSendText() {
        // Given

        let socket = SocketableMock()
        storage.add(.init(id: .init(), socket: socket))

        // When

        storage.forEach { client in
            client.send("text")
        }

        // Then

        XCTAssert(socket.sendCallsCount == 1, "Client must be called once!")
        XCTAssert(socket.sendReceivedText == "text", "Client must be called with the text \"text\"!")
    }
}
