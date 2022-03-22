//
//  Model+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor
import FluentPostgresDriver

extension Model {
    static func find(_ id: Self.IDValue?, on req: Request) -> EventLoopFuture<Self?> {
        find(id, on: req.db)
    }

    static func findOrAbort(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Self> {
        findOrAbort(id, on: req.db)
    }

    static func findOrAbort(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Self> {
        find(id, on: database).unwrapOrAbort(status)
    }

    static func findOrAbort<NewValue>(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound, flatMap: @escaping (Self) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        findOrAbort(id, on: req.db, status: status, flatMap: flatMap)
    }

    static func findOrAbort<NewValue>(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound, flatMap: @escaping (Self) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        findOrAbort(id, on: database, status: status)
            .flatMap(flatMap)
    }

    static func findOrAbortAndDelete(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Void> {
        findOrAbortAndDelete(id, on: req.db, status: status)
    }

    static func findOrAbortAndDelete(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Void> {
        findOrAbort(id, on: database, status: status, flatMap: {
            $0.delete(on: database)
        })
    }

    static func findOrAbortAndModify(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound, modify: @escaping (Self) -> Void) -> EventLoopFuture<Void> {
        findOrAbortAndModify(id, on: req.db, status: status, modify: modify)
    }

    static func findOrAbortAndModify(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound, modify: @escaping (Self) -> Void) -> EventLoopFuture<Void> {
        findOrAbort(id, on: database)
            .flatMap {
                modify($0)
                return $0.update(on: database)
            }
    }

    static func findOrAbortAndModifyThenTransform<NewValue>(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound, modify: @escaping (Self) -> Void, transformTo: NewValue) -> EventLoopFuture<NewValue> {
        findOrAbortAndModifyThenTransform(id, on: req.db, status: status, modify: modify, transformTo: transformTo)
    }

    static func findOrAbortAndModifyThenTransform<NewValue>(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound, modify: @escaping (Self) -> Void, transformTo: NewValue) -> EventLoopFuture<NewValue> {
        findOrAbort(id, on: database)
            .flatMap {
                modify($0)
                return $0.update(on: database, transformTo: transformTo)
            }
    }
}

extension Model {
    static func query(on req: Request) -> QueryBuilder<Self> {
        query(on: req.db)
    }

    static func queryAll(on req: Request) -> EventLoopFuture<[Self]> {
        queryAll(on: req.db)
    }

    static func queryAll<NewValue>(on req: Request, map: @escaping ([Self]) -> (NewValue)) -> EventLoopFuture<NewValue> {
        queryAll(on: req).map(map)
    }

    static func queryAll<NewValue>(on req: Request, flatMap: @escaping ([Self]) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        queryAll(on: req).flatMap(flatMap)
    }

    static func queryAll(on database: Database) -> EventLoopFuture<[Self]> {
        query(on: database).all()
    }

    static func queryAll<NewValue>(on database: Database, map: @escaping ([Self]) -> (NewValue)) -> EventLoopFuture<NewValue> {
        queryAll(on: database).map(map)
    }

    static func queryAll<NewValue>(on database: Database, flatMap: @escaping ([Self]) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        queryAll(on: database).flatMap(flatMap)
    }
}

extension Model {
    /// Create and save the model on the `request`'s database.
    /// - Parameter req: the incoming request that has a database attached to.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func create(on req: Request) -> EventLoopFuture<Void> {
        create(on: req.db)
    }

    /// Create and save the model on the `request`'s database.
    /// - Parameter req: the incoming request that has a database attached to.
    /// - Parameter transformTo: a value to that the result of the creation of the model will be transformed.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func create<T>(on req: Request, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        create(on: req.db, transformTo: instance())
    }

    /// Create and save the model on the `database`.
    /// - Parameter database: the database.
    /// - Parameter transformTo: a value to that the result of the creation of the model will be transformed.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func create<T>(on database: Database, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        create(on: database).transform(to: instance())
    }
}

extension Model {
    func update(on req: Request) -> EventLoopFuture<Void> {
        update(on: req.db)
    }

    func update<T>(on req: Request, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        update(on: req.db, transformTo: instance())
    }

    func update<T>(on database: Database, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        update(on: database).transform(to: instance())
    }
}

extension Model {
    func delete(force: Bool = false, on req: Request) -> EventLoopFuture<Void> {
        delete(force: force, on: req.db)
    }
}
