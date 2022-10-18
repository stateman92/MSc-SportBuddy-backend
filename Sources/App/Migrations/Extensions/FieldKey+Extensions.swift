//
//  FieldKey+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Fluent

extension FieldKey {
    static func key<T: RawRepresentable>(_ value: T) -> FieldKey where T.RawValue == String {
        .string(value.rawValue)
    }
}
