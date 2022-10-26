//
//  TimeInterval+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 26..
//

import Foundation

extension TimeInterval {
    static func minutes(_ int: Int) -> Self {
        Self(int * 60)
    }
}
