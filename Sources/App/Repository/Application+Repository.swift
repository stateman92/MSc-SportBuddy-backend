//
//  Application+Repository.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Vapor

extension Application {
    private struct Key: StorageKey {
        typealias Value = RepositoryRegistry
    }

    var repositories: RepositoryRegistry {
        if let storage = storage[Key.self] {
            return storage
        }
        let registry: RepositoryRegistry = .init(app: self)
        storage[Key.self] = registry
        return registry
    }
}
