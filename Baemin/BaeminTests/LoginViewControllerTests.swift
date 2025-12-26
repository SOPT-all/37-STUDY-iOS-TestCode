//
//  LoginViewControllerTests.swift
//  BaeminTests
//
//  Created by sun on 11/16/25.
//

import XCTest
@testable import Baemin

final class LoginViewControllerTests: XCTestCase {

    // MARK: - Properties

    private var sut: LoginViewController!
    private var navigationController: UINavigationController!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        sut = LoginViewController()
        navigationController = UINavigationController(rootViewController: sut)

        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        navigationController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_login_shouldNotPush_whenEmailIsInvalid() {
        // Given
        sut.emailField.setText("not-an-email")
        sut.passwordField.setText("ValidPass1!")
        XCTAssertEqual(navigationController.viewControllers.count, 1)

        // When
        sut.loginButton.sendActions(for: .touchUpInside)

        // Then
        XCTAssertEqual(
            navigationController.viewControllers.count,
            1,
            "이메일 형식이 잘못된 경우에는 화면 전환이 일어나면 안 됩니다."
        )
    }

    func test_login_shouldNotPush_whenPasswordIsInvalid() {
        // Given
        sut.emailField.setText("test@example.com")
        sut.passwordField.setText("123")
        XCTAssertEqual(navigationController.viewControllers.count, 1)

        // When
        sut.loginButton.sendActions(for: .touchUpInside)

        // Then
        XCTAssertEqual(
            navigationController.viewControllers.count,
            1,
            "비밀번호 형식이 잘못된 경우에는 화면 전환이 일어나면 안 됩니다."
        )
    }
}
