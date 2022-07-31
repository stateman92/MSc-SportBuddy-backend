//
//  RepositoryImpl+Models.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 21..
//

import Vapor
import FluentPostgresDriver

extension RepositoryImpl {
    /// Get the object of the given identifier.
    /// - Parameter id: the identifier of the given object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func find(_ id: T.IDValue?) -> EventLoopFuture<T?> {
        T.find(id, on: req.db)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func findOrAbort(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<T> {
        T.find(id, on: req.db).unwrapOrAbort(status)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else map the value to a new value.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Parameter flatMap: the mapping of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func findOrAbort<NewValue>(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound, flatMap: @escaping (T) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        T.findOrAbort(id, on: req.db, status: status)
            .flatMap(flatMap)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else delete the object from the repository.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func findOrAbortAndDelete(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Void> {
        T.findOrAbort(id, on: req.db, status: status, flatMap: {
            $0.delete(on: req.db)
        })
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else modify the value and update it in the repository.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Parameter modify: the modification of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func findOrAbortAndModify(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound, modify: @escaping (T) -> Void) -> EventLoopFuture<Void> {
        T.findOrAbort(id, on: req.db)
            .flatMap {
                modify($0)
                return $0.update(on: req.db)
            }
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else modify the value and update it in the repository, and then transform the value to a new value.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Parameter modify: the modification of the found object.
    /// - Parameter instance: the new value to be transformed the result of the modification.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func findOrAbortAndModifyThenTransform<NewValue>(_ id: T.IDValue?, status: HTTPResponseStatus = .notFound, modify: @escaping (T) -> Void, transformTo instance: NewValue) -> EventLoopFuture<NewValue> {
        T.findOrAbort(id, on: req.db)
            .flatMap {
                modify($0)
                return $0.update(on: req.db, transformTo: instance)
            }
    }
}

extension RepositoryImpl {
    /// Get all the objects of the repository.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func queryAll() -> EventLoopFuture<[T]> {
        T.queryAll(on: req.db)
    }

    /// Get all the objects of the repository and map the values.
    /// - Parameter map: the mapping of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func queryAll<NewValue>(map: @escaping ([T]) -> (NewValue)) -> EventLoopFuture<NewValue> {
        T.queryAll(on: req).map(map)
    }

    /// Get all the objects of the repository and map the values.
    /// - Parameter flatMap: the mapping of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func queryAll<NewValue>(flatMap: @escaping ([T]) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        T.queryAll(on: req).flatMap(flatMap)
    }
}

extension RepositoryImpl {
    /// Create an object in the repository and then transform the value to a new value.
    /// - Parameter model: the model to be created.
    /// - Parameter instance: the new value to be transformed the result of the modification.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func create<NewValue>(_ model: T, transformTo instance: @escaping @autoclosure () -> NewValue) -> EventLoopFuture<NewValue> {
        model.create(on: req.db).transform(to: instance())
    }
}

extension RepositoryImpl {
    /// Update an object in the repository and then transform the value to a new value.
    /// - Parameter model: the model to be updated.
    /// - Parameter instance: the new value to be transformed the result of the modification.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func update<NewValue>(_ model: T, transformTo instance: @escaping @autoclosure () -> NewValue) -> EventLoopFuture<NewValue> {
        model.update(on: req.db).transform(to: instance())
    }
}

extension RepositoryImpl {
    /// Delete the object from the repository.
    /// - Parameter model: the object.
    /// - Parameter force: whether to use force delete or not. By default `false`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func delete(_ model: T, force: Bool = false) -> EventLoopFuture<Void> {
        model.delete(force: force, on: req.db)
    }

    /// Delete all the objects from the repository.
    /// - Parameter force: whether to use force delete or not. By default `false`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func deleteAll(force: Bool = false) -> EventLoopFuture<Void> {
        T.deleteAll(on: req.db, force: force)
    }
}
