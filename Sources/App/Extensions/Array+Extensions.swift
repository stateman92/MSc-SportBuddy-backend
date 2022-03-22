//
//  Array+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

extension Array {
    /// An empty `Array`.
    static var empty: Self {
        .init()
    }
}

extension Array where Element == EventLoopFuture<Void> {
    /// Convert a collection of `EventLoopFuture<Void>`s to an `EventLoopFuture<Void>`.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func flatten(on req: Request) -> EventLoopFuture<Void> {
        flatten(on: req.eventLoop)
    }
}
