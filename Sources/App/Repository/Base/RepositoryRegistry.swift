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

    init(app: Application) {
        self.app = app
    }
}

extension RepositoryRegistry {
    func builder(_ req: Request) -> RepositoryFactory {
        .init(registry: self, req: req)
    }

    func make(_ schema: Constants.Schema, _ req: Request) -> RepositoryProtocol {
        guard let builder = builders[schema] else {
            fatalError("\(schema) didn't get registered in the registry.")
        }
        return builder(req)
    }

    func register(_ schema: Constants.Schema, _ builder: @escaping (Request) -> RepositoryProtocol) {
        builders[schema] = builder
    }
}
