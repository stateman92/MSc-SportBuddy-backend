//
//  Request+Repository.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Vapor

extension Request {
    /// Get a repository factory of the application.
    var repositories: RepositoryFactory {
        application.repositories.builder(self)
    }
}
