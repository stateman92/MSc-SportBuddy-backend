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
        // Given

        let token = Token()
        let encodedToken = token.encoded

        // When

        let decodedToken = Token(from: encodedToken)

        // Then

        XCTAssert(token == decodedToken, "The token and the decoded token must be equal!")
    }

    func testCheckValidity() {
        // Given

        let token = Token()

        // When

        let isValid = token.isValid(validityDuration: 5)

        // Then

        XCTAssert(isValid == true, "The token must be valid for 5 seconds!")
    }

    func testCheckInvalidity() {
        // Given

        let token = Token()

        // When

        wait(for: 2)
        let isValid = token.isValid(validityDuration: 1)

        // Then

        XCTAssert(isValid == false, "The token must be valid for 0.4 seconds!")
    }

    func testCheckValidityWithRefresh() {
        // Given

        var token = Token()

        // When

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            token.refresh()
        }
        wait(for: 4)
        let isValid = token.isValid(validityDuration: 3)

        // Then

        XCTAssert(isValid == true, "The token must be valid for 0.5 + 0.9 seconds!")
    }
}
