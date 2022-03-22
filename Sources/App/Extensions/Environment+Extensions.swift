//
//  Environment+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

extension Environment {
    /// Get a value from the `Environment`.
    /// - Parameter key: the key of the value.
    /// - Returns: The value.
    static func get(_ key: Constants.EnvironmentKey) -> String {
        get(key.key) ?? .empty
    }
}
