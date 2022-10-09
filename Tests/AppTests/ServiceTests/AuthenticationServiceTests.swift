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
        let password = "secretPassword1!"
        let hashedPassword = service.hash(password: password)
        XCTAssert(hashedPassword != password, "The password and the hashed version of it shouldn't be equal!")
    }

    func testCheckingHashedPasswordValidity() {
        let password = "secretPassword1!"
        let hashedPassword = service.hash(password: password)
        XCTAssert(hashedPassword != nil, "The hashing must be successful!")
        let isValid = service.isValid(password: password, hashedPassword: hashedPassword!)
        XCTAssert(isValid == true, "Give the same password must be valid!")
    }

    func testHashingInvalidWeakPassword() {
        let password = "weakPassword"
        let hashedPassword = service.hash(password: password)
        XCTAssert(hashedPassword == nil, "The hashing must be unsuccessful!")
    }

    func testHashingInvalidNilPassword() {
        let password: String? = nil
        let hashedPassword = service.hash(password: password)
        XCTAssert(hashedPassword == nil, "The hashing must be unsuccessful!")
    }

    func testCheckingPasswordValidity() {
        let password = "secretPassword1!"
        let isValid = service.isValid(password: password)
        XCTAssert(isValid == true, "This password must be valid!")
    }

    func testCheckingEmailValidity() {
        let email = "random@email.com"
        let isValid = service.isValid(email: email)
        XCTAssert(isValid == true, "This email must be valid!")
    }
}
