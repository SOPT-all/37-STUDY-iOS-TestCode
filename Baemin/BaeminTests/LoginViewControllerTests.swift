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

    func test_loginButton_shouldBeInactive_whenEmailAndPasswordAreEmpty() {
        // Given

        // When

        // Then
        XCTAssertFalse(
            sut.loginButton.isActive,
            "이메일과 비밀번호가 비어 있으면 로그인 버튼이 비활성화되어야 합니다."
        )
    }

    func test_loginButton_shouldBeActive_whenEmailAndPasswordAreFilled() {
        // Given
        sut.emailField.setText("test@example.com")
        sut.passwordField.setText("Password123!")

        // When

        // Then
        XCTAssertTrue(
            sut.loginButton.isActive,
            "이메일과 비밀번호가 모두 채워지면 로그인 버튼이 활성화되어야 합니다."
        )
    }

    func test_login_shouldPushWelcomeViewController_whenInputsAreValid() {
        // Given
        sut.emailField.setText("test@example.com")
        sut.passwordField.setText("ValidPass1!")
        XCTAssertEqual(
            navigationController.viewControllers.count,
            1,
            "초기에는 네비게이션 스택에 LoginViewController 하나만 있어야 합니다."
        )

        // When
        sut.loginButton.sendActions(for: .touchUpInside)

        // Then
        XCTAssertEqual(
            navigationController.viewControllers.count,
            2,
            "로그인에 성공하면 새로운 화면이 하나 push 되어야 합니다."
        )

        let top = navigationController.topViewController as? WelcomeViewController
        XCTAssertNotNil(
            top,
            "push된 화면은 WelcomeViewController여야 합니다."
        )
        XCTAssertEqual(
            top?.email,
            "test@example.com",
            "WelcomeViewController에는 로그인에 사용한 이메일이 전달되어야 합니다."
        )
    }

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
