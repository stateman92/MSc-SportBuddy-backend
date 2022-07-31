//
//  QueriableRepository.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Fluent

/// A common protocol for repositories that can be queried and thus has an associatedtype.
protocol QueriableRepository: Repository {
    associatedtype T: Model

    /// Query the repository.
    /// - Returns: The `QueryBuilder`.
    func query() -> QueryBuilder<T>

    /// Query the repository to get the object of the given identifier.
    /// - Parameter id: the identifier of the given object.
    /// - Returns: The `QueryBuilder`.
    func query(_ id: T.IDValue) -> QueryBuilder<T>

    /// Query the repository to get the objects of the given identifiers.
    /// - Parameter ids: the identifiers of the given objects.
    /// - Returns: The `QueryBuilder`.
    func query(_ ids: [T.IDValue]) -> QueryBuilder<T>

    /// Get all the objects of the repository.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func getAll() -> EventLoopFuture<[T]>

    /// Get the object of the given identifier.
    /// - Parameter id: the identifier of the given object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func get(_ id: T.IDValue) -> EventLoopFuture<T?>

    /// Get the objects of the given identifiers.
    /// - Parameter ids: the identifiers of the given objects.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func get(_ ids: [T.IDValue]) -> EventLoopFuture<[T]>

    /// Create an object in the repository.
    /// - Parameter model: the model to be created.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func create(_ model: T) -> EventLoopFuture<Void>

    /// Update an object in the repository.
    /// - Parameter model: the model to be updated.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func update(_ model: T) -> EventLoopFuture<Void>

    /// Delete the object from the repository.
    /// - Parameter id: the identifier of the given object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func delete(_ id: T.IDValue) -> EventLoopFuture<Void>

    /// Delete the objects from the repository.
    /// - Parameter ids: the identifiers of the given objects.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func delete(_ ids: [T.IDValue]) -> EventLoopFuture<Void>
}
