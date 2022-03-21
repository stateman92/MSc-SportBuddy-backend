//
//  Repository+Models.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 21..
//

import Vapor
import FluentPostgresDriver

extension Repository {
    func find(_ id: T.IDValue?) -> EventLoopFuture<T?> {
        T.find(id, on: req.db)
    }

    func findOrAbort(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<T> {
        T.find(id, on: req.db).unwrapOrAbort(status)
    }

    func findOrAbort<NewValue>(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound, flatMap: @escaping (T) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        T.findOrAbort(id, on: req.db, status: status)
            .flatMap(flatMap)
    }

    func findOrAbortAndDelete(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Void> {
        T.findOrAbort(id, on: req.db, status: status, flatMap: {
            $0.delete(on: req.db)
        })
    }

    func findOrAbortAndModify(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound, modify: @escaping (T) -> Void) -> EventLoopFuture<Void> {
        T.findOrAbort(id, on: req.db)
            .flatMap {
                modify($0)
                return $0.update(on: req.db)
            }
    }

    func findOrAbortAndModifyThenTransform<NewValue>(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound, modify: @escaping (T) -> Void, transformTo: NewValue) -> EventLoopFuture<NewValue> {
        T.findOrAbort(id, on: req.db)
            .flatMap {
                modify($0)
                return $0.update(on: req.db, transformTo: transformTo)
            }
    }
}

extension Repository {
    func queryAll() -> EventLoopFuture<[T]> {
        T.queryAll(on: req.db)
    }

    func queryAll<NewValue>(map: @escaping ([T]) -> (NewValue)) -> EventLoopFuture<NewValue> {
        T.queryAll(on: req).map(map)
    }

    func queryAll<NewValue>(flatMap: @escaping ([T]) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        T.queryAll(on: req).flatMap(flatMap)
    }
}

extension Repository {
    func create(_ model: T, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        model.create(on: req.db).transform(to: instance())
    }
}

extension Repository {
    func delete(_ model: T, force: Bool = false) -> EventLoopFuture<Void> {
        model.delete(force: force, on: req.db)
    }
}

extension Repository {
    func update<NewValue>(_ model: T, transformTo instance: @escaping @autoclosure () -> NewValue) -> EventLoopFuture<NewValue> {
        model.update(on: req.db).transform(to: instance())
    }
}
