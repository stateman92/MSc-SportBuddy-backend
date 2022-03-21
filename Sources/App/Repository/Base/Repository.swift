//
//  Repository.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Vapor
import Fluent
import FluentKit

struct Repository<T: Model>: QueriableRepositoryProtocol {
    let req: Request
}

extension Repository {
    func query() -> QueryBuilder<T> {
        T.query(on: req)
    }

    func query(_ id: T.IDValue) -> QueryBuilder<T> {
        query().filter(\._$id == id)
    }

    func query(_ ids: [T.IDValue]) -> QueryBuilder<T> {
        query().filter(\._$id ~~ ids)
    }
}

extension Repository {
    func getAll() -> EventLoopFuture<[T]> {
        query().all()
    }

    func get(_ id: T.IDValue) -> EventLoopFuture<T?> {
        get([id]).map(\.first)
    }

    func get(_ ids: [T.IDValue]) -> EventLoopFuture<[T]> {
        query(ids).all()
    }
}

extension Repository {
    func create(_ model: T) -> EventLoopFuture<Void> {
        model.create(on: req)
    }
}

extension Repository {
    func update(_ model: T) -> EventLoopFuture<Void> {
        model.update(on: req)
    }
}

extension Repository {
    func delete(_ id: T.IDValue) -> EventLoopFuture<Void> {
        delete([id])
    }

    func delete(_ ids: [T.IDValue]) -> EventLoopFuture<Void> {
        query(ids).delete()
    }
}
