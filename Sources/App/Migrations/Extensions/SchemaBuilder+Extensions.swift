//
//  SchemaBuilder+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Fluent

extension SchemaBuilder {
    @discardableResult func field<T: RawRepresentable>(_ value: T, _ dataType: DatabaseSchema.DataType) -> Self where T.RawValue == String {
        self.field(.key(value), dataType)
    }
}
