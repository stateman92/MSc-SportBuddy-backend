//
//  WebSocketStorageTests.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

@testable import App
import XCTest
import Vapor

final class WebSocketStorageTests: BaseTestCase { }

// MARK: - Tests

extension WebSocketStorageTests {
    func testStorageFind() {
        let storage = WebSocketStorage(eventLoop: MockEventLoop())
        let id = UUID()
        let socket = SocketableMock()
        storage.add(.init(id: id, socket: socket))
        let client = storage.find(id)
        XCTAssert(client != nil, "Client with given id must be found!")
    }

    func testStorageRemoveAndFind() {
        let storage = WebSocketStorage(eventLoop: MockEventLoop())
        let id = UUID()
        let socket = SocketableMock()
        storage.add(.init(id: id, socket: socket))
        storage.remove(id)
        let client = storage.find(id)
        XCTAssert(client == nil, "Client with given id must be removed and therefore not be found!")
    }

    func testStorageSendText() {
        let storage = WebSocketStorage(eventLoop: MockEventLoop())
        let id = UUID()
        let socket = SocketableMock()
        storage.add(.init(id: id, socket: socket))
        storage.forEach { client in
            client.send("text")
        }
        XCTAssert(socket.sendCallsCount == 1, "Client must be called once!")
        XCTAssert(socket.sendReceivedText == "text", "Client must be called with the text \"text\"!")
    }
}
