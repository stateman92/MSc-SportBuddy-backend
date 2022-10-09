//
//  TopLevel+Estensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Foundation

/// Check whether the app's tests are running or not.
var isTesting: Bool {
    NSClassFromString("XCTest") != nil
}
