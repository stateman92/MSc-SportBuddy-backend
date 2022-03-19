//
//  Collection+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 19..
//

import Vapor

extension Collection {
    func flatten<Value>(on request: Request) -> EventLoopFuture<[Value]> where Element == EventLoopFuture<Value> {
        flatten(on: request.eventLoop)
    }
}
