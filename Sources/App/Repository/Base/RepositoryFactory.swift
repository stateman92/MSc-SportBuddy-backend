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
    func make(_ id: Constants.Schema) -> RepositoryProtocol {
        registry.make(id, req)
    }
}
