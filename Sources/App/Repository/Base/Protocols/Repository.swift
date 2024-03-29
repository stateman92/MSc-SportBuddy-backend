//
//  Repository.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

import Vapor

/// A common protocol for repositories.
protocol Repository {
    /// Initialize a repository..
    /// - Parameter req: the request.
    init(req: Request)
}
