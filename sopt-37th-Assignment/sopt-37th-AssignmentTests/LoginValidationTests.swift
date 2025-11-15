//
//  LoginValidationTests.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 11/15/25.
//


import XCTest
@testable import sopt_37th_Assignment

final class LoginValidationTests: XCTestCase {
    
    var sut: LoginViewController!

    override func setUp() {
        super.setUp()
        sut = LoginViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_validEmail() {
        // Given
        sut.loadViewIfNeeded()
        sut.idTextField.textField.text = "test@example.com"
        
        // When
        let input = sut.idTextField.textField.text ?? ""
        
        // Then
        XCTAssertTrue(input.isValidEmail)
    }
}
