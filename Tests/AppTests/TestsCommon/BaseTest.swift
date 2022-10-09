//
//  BaseTest.swift
//
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

@testable import App
import XCTest

class BaseTestCase: XCTestCase { }

extension BaseTestCase {
    // MARK: Overridden methods

    override class func setUp() {
        super.setUp()
        DependencyInjector.registerDependencies()
    }
}
