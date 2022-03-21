//
//  QueriableRepositoryProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Fluent

protocol QueriableRepositoryProtocol: RepositoryProtocol {
    associatedtype T: Model

    func query() -> QueryBuilder<T>
    func query(_ id: T.IDValue) -> QueryBuilder<T>
    func query(_ ids: [T.IDValue]) -> QueryBuilder<T>

    func getAll() -> EventLoopFuture<[T]>
    func get(_ id: T.IDValue) -> EventLoopFuture<T?>
    func get(_ ids: [T.IDValue]) -> EventLoopFuture<[T]>

    func create(_ model: T) -> EventLoopFuture<Void>

    func update(_ model: T) -> EventLoopFuture<Void>

    func delete(_ id: T.IDValue) -> EventLoopFuture<Void>
    func delete(_ ids: [T.IDValue]) -> EventLoopFuture<Void>
}
