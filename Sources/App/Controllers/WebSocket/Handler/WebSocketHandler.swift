//
//  WebSocketHandler.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

import Vapor

protocol WebSocketHandler {
    init(eventLoop: EventLoop)
    func connect(_ req: Request, _ ws: WebSocket)
}
