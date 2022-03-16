//
//  AppTests.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        DependencyInjector.registerDependencies()
    }
    
    func testIsTesting() throws {
        let isTesting = isTesting()
        XCTAssert(isTesting)
    }
}
