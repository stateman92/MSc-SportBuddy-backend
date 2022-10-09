//
//  BaseTest.swift
//
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

import XCTest

extension XCTestCase {
    /// Wait for some seconds (synchronously).
    /// - Parameter seconds: how many seconds should it waits.
    func wait(for seconds: TimeInterval) {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting")], timeout: seconds)
    }
}
