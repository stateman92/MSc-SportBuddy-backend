//
//  Array+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

extension Array {
    static var empty: Self {
        .init()
    }
}

extension Array where Element == EventLoopFuture<Void> {
    func flatten(on request: Request) -> EventLoopFuture<Void> {
        flatten(on: request.eventLoop)
    }
}
