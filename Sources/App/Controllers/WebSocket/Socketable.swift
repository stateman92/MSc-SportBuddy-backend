//
//  File.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

import Vapor
import NIOWebSocket

protocol Socketable: AutoMockable {
    var isClosed: Bool { get }
    func close()
    func send(_ text: String)
}

// MARK: - Socketable

extension WebSocket: Socketable {
    func close() {
        try! close(code: .goingAway).wait()
    }

    func send(_ text: String) {
        send(text, promise: nil)
    }
}
