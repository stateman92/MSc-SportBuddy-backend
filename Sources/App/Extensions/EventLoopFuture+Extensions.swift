//
//  EventLoopFuture+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

extension EventLoopFuture where Value: OptionalType {
    func unwrapOrAbort(_ status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Value.WrappedType> {
        unwrap(or: Abort(status))
    }
}
