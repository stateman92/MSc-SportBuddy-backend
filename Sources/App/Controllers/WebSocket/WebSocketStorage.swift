//
//  WebSocketStorage.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

import Vapor

final class WebSocketStorage {
    // MARK: Properties

    private let eventLoop: EventLoop
    private var storage: [UUID: WebSocketClient]

    private var active: [WebSocketClient] {
        storage.values.filter { !$0.isClosed }
    }

    // MARK: Initialization

    init(eventLoop: EventLoop, clients: [UUID: WebSocketClient] = [:]) {
        self.eventLoop = eventLoop
        self.storage = clients
    }

    deinit {
        let futures = storage.values.map { $0.close() }
        try! eventLoop.flatten(futures).wait()
    }
}

// MARK: - Public methods

extension WebSocketStorage {
    func add(_ client: WebSocketClient) {
        storage[client.identifier] = client
    }

    func remove(_ client: WebSocketClient) {
        storage[client.identifier] = nil
    }

    func find(_ uuid: UUID) -> WebSocketClient? {
        storage[uuid]
    }

    func forEach(_ body: (WebSocketClient) -> Void) {
        storage.map(\.value).forEach(body)
    }
}
