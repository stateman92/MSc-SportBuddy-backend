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
    private let socket: WebSocket
    var isClosed: Bool {
        socket.isClosed
    }
    var identifier: UUID {
        id
    }

    // MARK: Initialization

    init(id: UUID, socket: WebSocket) {
        self.id = id
        self.socket = socket
    }
}

extension WebSocketClient {
    func close() -> EventLoopFuture<Void> {
        socket.close()
    }

    func send(_ text: String) {
        socket.send(text)
    }
}
