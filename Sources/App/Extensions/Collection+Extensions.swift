//
//  Collection+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 19..
//

import Vapor

extension Collection {
    /// Convert a collection of `EventLoopFuture<Void>`s to an `EventLoopFuture<Void>`.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later. 
    func flatten<Value>(on req: Request) -> EventLoopFuture<[Value]> where Element == EventLoopFuture<Value> {
        flatten(on: req.eventLoop)
    }
}
