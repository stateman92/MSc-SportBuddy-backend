//
//  MockEventLoop.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

import Vapor
import NIOCore

final class MockEventLoop { }

// MARK: - EventLoop

extension MockEventLoop: EventLoop {
    var inEventLoop: Bool {
        true
    }

    func execute(_ task: @escaping () -> Void) {
        task()
    }

    func scheduleTask<T>(deadline: NIOCore.NIODeadline, _ task: @escaping () throws -> T) -> NIOCore.Scheduled<T> {
        .init(promise: makePromise(of: T.self), cancellationTask: { })
    }

    func scheduleTask<T>(in: NIOCore.TimeAmount, _ task: @escaping () throws -> T) -> NIOCore.Scheduled<T> {
        .init(promise: makePromise(of: T.self), cancellationTask: { })
    }

    func shutdownGracefully(queue: DispatchQueue, _ callback: @escaping (Error?) -> Void) {
        callback(nil)
    }
}
