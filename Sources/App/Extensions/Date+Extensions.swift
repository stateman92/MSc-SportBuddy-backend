//
//  Date+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Foundation

extension Date {
    var secondsSince1970: Int {
        Int(timeIntervalSince1970)
    }

    init(secondsSince1970: Int) {
        self.init(timeIntervalSince1970: TimeInterval(secondsSince1970))
    }
}
