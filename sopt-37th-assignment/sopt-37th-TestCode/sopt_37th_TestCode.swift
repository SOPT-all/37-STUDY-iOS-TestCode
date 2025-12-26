//
//  sopt_37th_TestCode.swift
//  sopt-37th-TestCode
//
//  Created by 이나연 on 11/15/25.
//

import XCTest
@testable import sopt_37th_assignment

final class sopt_37th_TestCode: XCTestCase {
    private var loginViewController: LoginViewController?

    override func setUpWithError() throws {
        loginViewController = LoginViewController()
    }

    override func tearDownWithError() throws {
        loginViewController = nil
    }

    func test_whenBothTextFieldsHaveText_thenLoginButtonIsEnabled() throws {
        // Given
        let idTextField = loginViewController?.rootView.idTextField.textField
        let passwordTextField = loginViewController?.rootView.passwordTextField.textField
        let loginButton = loginViewController?.rootView.loginButton
        
        // When
        idTextField?.text = "test"
        passwordTextField?.text = "test"
        loginViewController?.textFieldDidChange()
        
        // Then
        XCTAssertTrue(loginButton!.isEnabled)
        
        // When
        idTextField?.text = ""
        passwordTextField?.text = "test"
        loginViewController?.textFieldDidChange()
        
        // Then
        XCTAssertFalse(loginButton!.isEnabled)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
