//
//  TokenTests.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

@testable import App
import XCTest

final class TokenTests: BaseTestCase { }

// MARK: - Tests

extension TokenTests {
    func testTokenCoding() {
        let token = Token()
        let encodedToken = token.encoded
        let decodedToken = Token(from: encodedToken)
        XCTAssert(token == decodedToken, "The token and the decoded token must be equal!")
    }

    func testCheckValidity() {
        let token = Token()
        let isValid = token.isValid(validityDuration: 5)
        XCTAssert(isValid == true, "The token must be valid for 5 seconds!")
    }

    func testCheckInvalidity() {
        let token = Token()
        wait(for: 2)
        let isValid = token.isValid(validityDuration: 1)
        XCTAssert(isValid == false, "The token must be valid for 0.4 seconds!")
    }

    func testCheckValidityWithRefresh() {
        var token = Token()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            token.refresh()
        }
        wait(for: 4)
        let isValid = token.isValid(validityDuration: 3)
        XCTAssert(isValid == true, "The token must be valid for 0.5 + 0.9 seconds!")
    }
}
