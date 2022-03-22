//
//  Model+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor
import FluentPostgresDriver

extension Model {
    /// Get the object of the given identifier.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func find(_ id: Self.IDValue?, on req: Request) -> EventLoopFuture<Self?> {
        find(id, on: req.db)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter req: the request.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbort(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Self> {
        findOrAbort(id, on: req.db)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter database: the database.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbort(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Self> {
        find(id, on: database).unwrapOrAbort(status)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else map the value to a new value.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter req: the request.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Parameter flatMap: the mapping of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbort<NewValue>(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound, flatMap: @escaping (Self) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        findOrAbort(id, on: req.db, status: status, flatMap: flatMap)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else map the value to a new value.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter database: the database.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Parameter flatMap: the mapping of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbort<NewValue>(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound, flatMap: @escaping (Self) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        findOrAbort(id, on: database, status: status)
            .flatMap(flatMap)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else delete the object from the repository.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter req: the request.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbortAndDelete(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Void> {
        findOrAbortAndDelete(id, on: req.db, status: status)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else delete the object from the repository.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter database: the database.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbortAndDelete(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound) -> EventLoopFuture<Void> {
        findOrAbort(id, on: database, status: status, flatMap: {
            $0.delete(on: database)
        })
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else modify the value and update it in the repository.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter req: the request.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Parameter modify: the modification of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbortAndModify(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound, modify: @escaping (Self) -> Void) -> EventLoopFuture<Void> {
        findOrAbortAndModify(id, on: req.db, status: status, modify: modify)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else modify the value and update it in the repository.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter database: the database.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Parameter modify: the modification of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbortAndModify(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound, modify: @escaping (Self) -> Void) -> EventLoopFuture<Void> {
        findOrAbort(id, on: database)
            .flatMap {
                modify($0)
                return $0.update(on: database)
            }
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else modify the value and update it in the repository, and then transform the value to a new value.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter req: the request.
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Parameter modify: the modification of the found object.
    /// - Parameter instance: the new value to be transformed the result of the modification.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbortAndModifyThenTransform<NewValue>(_ id: Self.IDValue?, on req: Request, status: HTTPResponseStatus = .notFound, modify: @escaping (Self) -> Void, transformTo instance: NewValue) -> EventLoopFuture<NewValue> {
        findOrAbortAndModifyThenTransform(id, on: req.db, status: status, modify: modify, transformTo: instance)
    }

    /// Get the object of the given identifier of abort it with the given status if no object is found, else modify the value and update it in the repository, and then transform the value to a new value.
    /// - Parameter id: the identifier of the given object.
    /// - Parameter database: the database. 
    /// - Parameter status: the status of abort (if neccessary to use). By default `.notFound`.
    /// - Parameter modify: the modification of the found object.
    /// - Parameter instance: the new value to be transformed the result of the modification.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func findOrAbortAndModifyThenTransform<NewValue>(_ id: Self.IDValue?, on database: Database, status: HTTPResponseStatus = .notFound, modify: @escaping (Self) -> Void, transformTo instance: NewValue) -> EventLoopFuture<NewValue> {
        findOrAbort(id, on: database)
            .flatMap {
                modify($0)
                return $0.update(on: database, transformTo: instance)
            }
    }
}

extension Model {
    /// Query the objects of the type.
    /// - Parameter req: the request.
    /// - Returns: The `QueryBuilder`.
    static func query(on req: Request) -> QueryBuilder<Self> {
        query(on: req.db)
    }

    /// Get all the objects of the type.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func queryAll(on req: Request) -> EventLoopFuture<[Self]> {
        queryAll(on: req.db)
    }

    /// Get all the objects of the type and map the values.
    /// - Parameter req: the request.
    /// - Parameter map: the mapping of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func queryAll<NewValue>(on req: Request, map: @escaping ([Self]) -> (NewValue)) -> EventLoopFuture<NewValue> {
        queryAll(on: req).map(map)
    }

    /// Get all the objects of the type and map the values.
    /// - Parameter req: the request.
    /// - Parameter flatMap: the mapping of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func queryAll<NewValue>(on req: Request, flatMap: @escaping ([Self]) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        queryAll(on: req).flatMap(flatMap)
    }

    /// Get all the objects of the type.
    /// - Parameter database: the database.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func queryAll(on database: Database) -> EventLoopFuture<[Self]> {
        query(on: database).all()
    }

    /// Get all the objects of the type and map the values.
    /// - Parameter database: the database.
    /// - Parameter map: the mapping of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func queryAll<NewValue>(on database: Database, map: @escaping ([Self]) -> (NewValue)) -> EventLoopFuture<NewValue> {
        queryAll(on: database).map(map)
    }

    /// Get all the objects of the type and map the values.
    /// - Parameter database: the database.
    /// - Parameter flatMap: the mapping of the found object.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func queryAll<NewValue>(on database: Database, flatMap: @escaping ([Self]) -> (EventLoopFuture<NewValue>)) -> EventLoopFuture<NewValue> {
        queryAll(on: database).flatMap(flatMap)
    }
}

extension Model {
    /// Create an object in the repository.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func create(on req: Request) -> EventLoopFuture<Void> {
        create(on: req.db)
    }

    /// Create an object in the repository and then transform the value to a new value.
    /// - Parameter req: the request.
    /// - Parameter instance: the new value to be transformed the result of the modification.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func create<T>(on req: Request, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        create(on: req.db, transformTo: instance())
    }

    /// Create an object in the repository and then transform the value to a new value.
    /// - Parameter database: the database.
    /// - Parameter instance: the new value to be transformed the result of the modification.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func create<T>(on database: Database, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        create(on: database).transform(to: instance())
    }
}

extension Model {
    /// Update an object in the repository.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func update(on req: Request) -> EventLoopFuture<Void> {
        update(on: req.db)
    }

    /// Update an object in the repository and then transform the value to a new value.
    /// - Parameter req: the request.
    /// - Parameter instance: the new value to be transformed the result of the modification.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func update<T>(on req: Request, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        update(on: req.db, transformTo: instance())
    }

    /// Update an object in the repository and then transform the value to a new value.
    /// - Parameter database: the database.
    /// - Parameter instance: the new value to be transformed the result of the modification.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func update<T>(on database: Database, transformTo instance: @escaping @autoclosure () -> T) -> EventLoopFuture<T> {
        update(on: database).transform(to: instance())
    }
}

extension Model {
    /// Delete the object from the repository.
    /// - Parameter force: whether to use force delete or not. By default `false`.
    /// - Parameter req: the request.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    func delete(force: Bool = false, on req: Request) -> EventLoopFuture<Void> {
        delete(force: force, on: req.db)
    }

    /// Delete all the objects from the repository.
    /// - Parameter req: the request.
    /// - Parameter force: whether to use force delete or not. By default `false`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func deleteAll(on req: Request, force: Bool = false) -> EventLoopFuture<Void> {
        deleteAll(on: req.db, force: force)
    }

    /// Delete all the objects from the repository.
    /// - Parameter database: the database.
    /// - Parameter force: whether to use force delete or not. By default `false`.
    /// - Returns: An `EventLoopFuture`, which is a holder for a result that will be provided later.
    static func deleteAll(on database: Database, force: Bool = false) -> EventLoopFuture<Void> {
        query(on: database).delete(force: force)
    }
}
