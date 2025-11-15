//
//  BaeminTests.swift
//  BaeminTests
//
//  Created by 김호성 on 2025.11.13.
//

import XCTest
@testable import Baemin

final class BaeminTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
    }
    
    func testIsValidEmail_withValidEmail_returnsTrue() throws {
        // Given
        let email = "hosungkim5108@gmail.com"
        // When
        let isValid = email.isValidEmail()
        // Then
        XCTAssertTrue(isValid)
    }

    func testIsValidEmail_withoutAtSymbol_returnsFalse() throws {
        // Given
        let email = "hosungkim5108gmail.com"
        // When
        let isValid = email.isValidEmail()
        // Then
        XCTAssertFalse(isValid)
    }

    func testIsValidEmail_withoutTopLevelDomain_returnsFalse() throws {
        // Given
        let email = "hosungkim5108gmail"
        // When
        let isValid = email.isValidEmail()
        // Then
        XCTAssertFalse(isValid)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
