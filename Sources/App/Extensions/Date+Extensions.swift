//
//  Date+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Foundation

extension Date {
    /// Get the number of seconds since 1970.
    var secondsSince1970: Int {
        Int(timeIntervalSince1970)
    }

    /// Initialize a `Date`.
    /// - Parameter secondsSince1970: the number of seconds since 1970.
    init(secondsSince1970: Int) {
        self.init(timeIntervalSince1970: TimeInterval(secondsSince1970))
    }
}
