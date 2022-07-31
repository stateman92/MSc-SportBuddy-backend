//
//  RepositoryImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Vapor
import Fluent
import FluentKit

struct RepositoryImpl<T: Model> {
    let req: Request
}

// MARK: - QueriableRepository

extension RepositoryImpl: QueriableRepository {
    /// Query the repository.
    /// - Returns: The `QueryBuilder`.
    func query() -> QueryBuilder<T> {
        T.query(on: req)
    }

    /// Query the repository to get the object of the given identifier.
    /// - Parameter id: the identifier of the given object.
    /// - Returns: The `QueryBuilder`.
    func query(_ id: T.IDValue) -> QueryBuilder<T> {
        query().filter(\._$id == id)
    }

    /// Query the repository to get the objects of the given identifiers.
    /// - Parameter ids: the identifiers of the given objects.
    /// - Returns: The `QueryBuilder`.
    func query(_ ids: [T.IDValue]) -> QueryBuilder<T> {
        query().filter(\._$id ~~ ids)
    }
}

extension RepositoryImpl {
    /// Get all the objects of the repository.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func getAll() -> EventLoopFuture<[T]> {
        query().all()
    }

    /// Get the object of the given identifier.
    /// - Parameter id: the identifier of the given object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func get(_ id: T.IDValue) -> EventLoopFuture<T?> {
        get([id]).map(\.first)
    }

    /// Get the objects of the given identifiers.
    /// - Parameter ids: the identifiers of the given objects.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func get(_ ids: [T.IDValue]) -> EventLoopFuture<[T]> {
        query(ids).all()
    }
}

extension RepositoryImpl {
    /// Create an object in the repository.
    /// - Parameter model: the model to be created.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func create(_ model: T) -> EventLoopFuture<Void> {
        model.create(on: req)
    }
}

extension RepositoryImpl {
    /// Update an object in the repository.
    /// - Parameter model: the model to be updated.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func update(_ model: T) -> EventLoopFuture<Void> {
        model.update(on: req)
    }
}

extension RepositoryImpl {
    /// Delete the object from the repository.
    /// - Parameter id: the identifier of the given object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func delete(_ id: T.IDValue) -> EventLoopFuture<Void> {
        delete([id])
    }

    /// Delete the objects from the repository.
    /// - Parameter ids: the identifiers of the given objects.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func delete(_ ids: [T.IDValue]) -> EventLoopFuture<Void> {
        query(ids).delete()
    }
}
