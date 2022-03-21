//
//  Request+Repository.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Vapor

extension Request {
    var repositories: RepositoryFactory {
        application.repositories.builder(self)
    }
}
