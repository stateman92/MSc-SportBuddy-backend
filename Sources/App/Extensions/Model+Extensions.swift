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
        find(id, on: request.db).unwrapOrAbort(status)
    }

    static func query(on request: Request) -> QueryBuilder<Self> {
        query(on: request.db)
    }
    
    static func queryAll(on request: Request) -> EventLoopFuture<[Self]> {
        query(on: request.db).all()
    }

    static func queryAll<NewValue>(on request: Request, map: @escaping ([Self]) -> (NewValue)) -> EventLoopFuture<NewValue>{
        queryAll(on: request).map(map)
    }

    static func queryAll<NewValue>(on request: Request, flatMap: @escaping ([Self]) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue>{
        queryAll(on: request).flatMap(flatMap)
    }

    func create(on request: Request) -> EventLoopFuture<Void> {
        create(on: request.db)
    }

    func create<T>(on request: Request, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        create(on: request).transform(to: instance())
    }

    func delete(force: Bool = false, on request: Request) -> EventLoopFuture<Void> {
        delete(force: force, on: request.db)
    }

    func update(on request: Request) -> EventLoopFuture<Void> {
        update(on: request.db)
    }

    func update<T>(on request: Request, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        update(on: request).transform(to: instance())
    }
}
