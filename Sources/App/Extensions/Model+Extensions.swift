//
//  Model+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor
import FluentPostgresDriver

extension Model {
    static func find(_ id: Self.IDValue?, on request: Request) -> EventLoopFuture<Self?> {
        find(id, on: request.db)
    }

    static func findOrAbort(_ id: Self.IDValue?, on request: Request, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Self> {
        findOrAbort(id, on: request.db)
    }

    static func findOrAbort(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Self> {
        find(id, on: database).unwrapOrAbort(status)
    }

    static func findOrAbort<NewValue>(_ id: Self.IDValue?, on request: Request, status: HTTPResponseStatus = .notFound, flatMap: @escaping (Self) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        findOrAbort(id, on: request.db, status: status, flatMap: flatMap)
    }

    static func findOrAbort<NewValue>(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound, flatMap: @escaping (Self) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        findOrAbort(id, on: database, status: status)
            .flatMap(flatMap)
    }

    static func findOrAbortAndDelete(_ id: Self.IDValue?, on request: Request, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Void> {
        findOrAbortAndDelete(id, on: request.db, status: status)
    }

    static func findOrAbortAndDelete(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Void> {
        findOrAbort(id, on: database, status: status, flatMap: {
            $0.delete(on: database)
        })
    }
}

extension Model {
    static func query(on request: Request) -> QueryBuilder<Self> {
        query(on: request.db)
    }

    static func queryAll(on request: Request) -> EventLoopFuture<[Self]> {
        queryAll(on: request.db)
    }

    static func queryAll<NewValue>(on request: Request, map: @escaping ([Self]) -> (NewValue)) -> EventLoopFuture<NewValue>{
        queryAll(on: request).map(map)
    }

    static func queryAll<NewValue>(on request: Request, flatMap: @escaping ([Self]) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue>{
        queryAll(on: request).flatMap(flatMap)
    }

    static func queryAll(on database: Database) -> EventLoopFuture<[Self]> {
        query(on: database).all()
    }

    static func queryAll<NewValue>(on database: Database, map: @escaping ([Self]) -> (NewValue)) -> EventLoopFuture<NewValue>{
        queryAll(on: database).map(map)
    }

    static func queryAll<NewValue>(on database: Database, flatMap: @escaping ([Self]) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue>{
        queryAll(on: database).flatMap(flatMap)
    }
}

extension Model {
    func create(on request: Request) -> EventLoopFuture<Void> {
        create(on: request.db)
    }

    func create<T>(on request: Request, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        create(on: request.db, transformTo: instance())
    }

    func create<T>(on database: Database, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        create(on: database).transform(to: instance())
    }
}

extension Model {
    func delete(force: Bool = false, on request: Request) -> EventLoopFuture<Void> {
        delete(force: force, on: request.db)
    }
}

extension Model {
    func update(on request: Request) -> EventLoopFuture<Void> {
        update(on: request.db)
    }

    func update<T>(on request: Request, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        update(on: request).transform(to: instance())
    }
}
