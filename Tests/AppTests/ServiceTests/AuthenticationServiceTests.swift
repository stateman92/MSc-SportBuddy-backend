//
//  AuthenticationServiceTests.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

@testable import App
import XCTest

final class AuthenticationServiceTests: BaseTestCase {
    // MARK: Properties

    private let service = AuthenticationServiceImpl()
}

// MARK: - Tests

extension AuthenticationServiceTests {
    func testHashingPassword() {
        // Given

        let password = "secretPassword1!"

        // When

        let hashedPassword = service.hash(password: password)

        // Then

        XCTAssert(hashedPassword != password, "The password and the hashed version of it shouldn't be equal!")
    }

    func testCheckingHashedPasswordValidity() {
        // Given

        let password = "secretPassword1!"

        // When

        let hashedPassword = service.hash(password: password)
        let isValid = service.isValid(password: password, hashedPassword: hashedPassword!)

        // Then

        XCTAssert(hashedPassword != nil, "The hashing must be successful!")
        XCTAssert(isValid == true, "Give the same password must be valid!")
    }

    func testHashingInvalidWeakPassword() {
        // Given

        let password = "weakPassword"

        // When

        let hashedPassword = service.hash(password: password)

        // Then

        XCTAssert(hashedPassword == nil, "The hashing must be unsuccessful!")
    }

    func testHashingInvalidNilPassword() {
        // Given

        let password: String? = nil

        // When

        let hashedPassword = service.hash(password: password)

        // Then

        XCTAssert(hashedPassword == nil, "The hashing must be unsuccessful!")
    }

    func testCheckingPasswordValidity() {
        // Given

        let password = "secretPassword1!"

        // When

        let isValid = service.isValid(password: password)

        // Then

        XCTAssert(isValid == true, "This password must be valid!")
    }

    func testCheckingEmailValidity() {
        // Given

        let email = "random@email.com"

        // When

        let isValid = service.isValid(email: email)

        // Then

        XCTAssert(isValid == true, "This email must be valid!")
    }
}
