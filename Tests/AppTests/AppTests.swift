//
//  AppTests.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

@testable import App
import XCTest

final class AppTests: BaseTestCase { }

// MARK: - Tests

extension AppTests {
    func testIsTesting() {
        let isTesting = isTesting
        XCTAssert(isTesting)
    }
}
