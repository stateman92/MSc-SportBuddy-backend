//
//  TopLevel+Estensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Foundation

func isTesting() -> Bool {
    NSClassFromString("XCTest") != nil
}
