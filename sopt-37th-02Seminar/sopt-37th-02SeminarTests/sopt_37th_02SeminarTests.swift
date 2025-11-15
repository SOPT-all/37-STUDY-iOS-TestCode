//
//  sopt_37th_02SeminarTests.swift
//  sopt-37th-02SeminarTests
//
//  Created by JIN on 11/15/25.
//

import XCTest
@testable import sopt_37th_02Seminar

final class sopt_37th_02SeminarTests: XCTestCase {

    var sut: LoginValidator!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginValidator()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    // MARK: - Login Validation Tests

    func test_isValidEmail_ValidEmailProvided_ReturnsTrue() throws {
        // Given
        let validEmails = [
            "test@example.com",
            "user.name@domain.co.kr",
            "user+tag@example.com",
            "test123@test-domain.com"
        ]

        // When & Then
        for email in validEmails {
            let result = sut.isValidEmail(email)
            XCTAssertTrue(result, "Expected '\(email)' to be valid")
        }
    }

    func test_isValidEmail_InvalidEmailProvided_ReturnsFalse() throws {
        // Given
        let invalidEmails = [
            "notanemail",
            "@example.com",
            "user@",
            "user@domain",
            "",
            "user name@example.com",
            nil
        ]

        // When & Then
        for email in invalidEmails {
            let result = sut.isValidEmail(email)
            XCTAssertFalse(result, "Expected '\(email ?? "nil")' to be invalid")
        }
    }

    func test_isValidPassword_ValidPasswordProvided_ReturnsTrue() throws {
        // Given
        let validPasswords = [
            "Test1234!",
            "MyP@ssw0rd",
            "SecurePass123#",
            "Abcd123!@#"
        ]

        // When & Then
        for password in validPasswords {
            let result = sut.isValidPassword(password)
            XCTAssertTrue(result, "Expected '\(password)' to be valid (must contain letters, numbers, special chars, and be 8+ chars)")
        }
    }

    func test_isValidPassword_InvalidPasswordProvided_ReturnsFalse() throws {
        // Given
        let invalidPasswords = [
            "short1!", //8자리 이하
            "NoNumbers!", //숫자없음
            "NoSpecial123", //특수문자없음
            "12345678!", //글자없음
            "",  //빈값
            nil  //nil 값
        ]

        // When & Then
        for password in invalidPasswords {
            let result = sut.isValidPassword(password)
            XCTAssertFalse(result, "Expected '\(password ?? "nil")' to be invalid")
        }
    }
}

