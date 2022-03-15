//
//  Environment+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

extension Environment {
    static func get(_ key: Constants.EnvironmentKey) -> String {
        get(key.key) ?? .empty
    }
}
