//
//  TimestampProperty+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Fluent

extension TimestampProperty {
    convenience init<T: RawRepresentable>(_ value: T, on trigger: TimestampTrigger, format: TimestampFormatFactory<Format> = .iso8601) where T.RawValue == String {
        self.init(key: .key(value), on: trigger, format: format)
    }
}

