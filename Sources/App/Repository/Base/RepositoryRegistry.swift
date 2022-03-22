//
//  RepositoryRegistry.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Vapor

final class RepositoryRegistry {
    private let app: Application
    private var builders: [Constants.Schema: ((Request) -> RepositoryProtocol)] = [:]

    /// Initialize a registry.
    /// - Parameter app: the application.
    init(app: Application) {
        self.app = app
    }
}

extension RepositoryRegistry {
    /// Create a repository factory.
    /// - Parameter req: the request.
    /// - Returns: The repository.
    func builder(_ req: Request) -> RepositoryFactory {
        .init(registry: self, req: req)
    }

    /// Get a repository.
    /// - Parameter schema: the schema of the desired repository.
    /// - Parameter req: the request.
    /// - Returns: The repository.
    func make(_ schema: Constants.Schema, _ req: Request) -> RepositoryProtocol {
        guard let builder = builders[schema] else {
            fatalError("\(schema) didn't get registered in the registry.")
        }
        return builder(req)
    }

    /// Register a repository.
    /// - Parameter schema: the schema of the repository that is being registered.
    /// - Parameter builder: the builder that shows how to create such a repository.
    func register(_ schema: Constants.Schema, _ builder: @escaping (Request) -> RepositoryProtocol) {
        builders[schema] = builder
    }
}
