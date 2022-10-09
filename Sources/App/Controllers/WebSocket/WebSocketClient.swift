//
//  WebSocketClient.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

import Vapor

final class WebSocketClient {
    // MARK: Properties

    private let id: UUID
    private let socket: Socketable
    var isClosed: Bool {
        socket.isClosed
    }
    var identifier: UUID {
        id
    }

    // MARK: Initialization

    init(id: UUID, socket: Socketable) {
        self.id = id
        self.socket = socket
    }
}

// MARK: - Public methods

extension WebSocketClient {
    func close() {
        socket.close()
    }

    func send(_ text: String) {
        socket.send(text)
    }
}
