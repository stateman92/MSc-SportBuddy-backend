//
//  Database+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver

extension Database {
    /// Get a `SchemaBuilder`.
    /// - Parameter tableName: the name of the schema.
    /// - Returns: The `SchemaBuilder`.
    func schema(_ tableName: Constants.Schema) -> SchemaBuilder {
        schema(tableName.rawValue)
    }
}
