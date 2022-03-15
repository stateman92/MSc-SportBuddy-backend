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
    
    func testHelloWorld() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try app.setup()

        try app.test(.GET, "test", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
    }
}
