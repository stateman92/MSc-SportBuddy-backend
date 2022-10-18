//
//  FieldProperty+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Fluent

extension FieldProperty {
    convenience init<T: RawRepresentable>(_ value: T) where T.RawValue == String {
        self.init(key: .key(value))
    }
}
