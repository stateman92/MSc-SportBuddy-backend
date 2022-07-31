//
//  RepositoryFactory.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Vapor

struct RepositoryFactory {
    let registry: RepositoryRegistry
    let req: Request
}

extension RepositoryFactory {
    /// Get a repository.
    /// - Parameter schema: the schema of the desired repository.
    /// - Returns: The repository.
    func make(_ schema: Constants.Schema) -> Repository {
        registry.make(schema, req)
    }
}
