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
        storage.values.forEach { $0.close() }
    }
}

// MARK: - Public methods

extension WebSocketStorage {
    func add(_ client: WebSocketClient) {
        storage[client.identifier] = client
    }

    func remove(_ uuid: UUID) {
        storage[uuid] = nil
    }

    func find(_ uuid: UUID) -> WebSocketClient? {
        storage[uuid]
    }

    func forEach(_ body: (WebSocketClient) -> Void) {
        storage.map(\.value).forEach(body)
    }
}
