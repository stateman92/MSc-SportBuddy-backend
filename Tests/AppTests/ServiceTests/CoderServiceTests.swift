//
//  CoderServiceTests.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 09..
//

@testable import App
import XCTest

final class CoderServiceTests: BaseTestCase {
    // MARK: Properties

    private let service = CoderServiceImpl()
}

// MARK: - Tests

extension CoderServiceTests {
    func testCodingData() {
        // Given

        let data = "data"
        let encodedData = service.encode(object: data)

        // When

        let decodedData: String? = service.decode(data: encodedData)

        // Then

        XCTAssert(data == decodedData, "The data and the decoded data must be equal!")
    }

    func testCodingString() {
        // Given

        let data = 5
        let encodedData: String? = service.encode(object: data)

        // When

        let decodedData: Int? = service.decode(string: encodedData)

        // Then

        XCTAssert(data == decodedData, "The data and the decoded data must be equal!")
    }
}
