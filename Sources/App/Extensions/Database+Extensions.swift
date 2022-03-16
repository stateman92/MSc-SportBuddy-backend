//
//  Database+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver

extension Database {
    func schema(_ tableName: Constants.Schema) -> SchemaBuilder {
        schema(tableName.rawValue)
    }
}
