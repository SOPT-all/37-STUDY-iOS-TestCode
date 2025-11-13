//
//  SOPT_Test_Code_StudyTests.swift
//  SOPT-Test-Code-StudyTests
//
//  Created by 이승준 on 11/13/25.
//

import XCTest
@testable import SOPT_Test_Code_Study

final class SOPT_Test_Code_StudyTests: XCTestCase {
    
    var sut: LoginViewController!
    var helper: LoginViewControllerTestHelper!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // 1. LoginViewController 인스턴스 생성
        sut = LoginViewController()
        // 2. viewDidLoad() 호출
        _ = sut.view
        // 3. testHelper 환경 구축
        sut.setTestEnvironment()
        guard let testHelper = sut.testHelper else {
            XCTFail("LoginViewControllerTestHelper should be initialized.")
            return
        }
        helper = testHelper
    }
    
    override func tearDownWithError() throws {
        sut = nil
        helper = nil
        super.tearDown()
    }
    
    func test_checkLoginButtonValid_shouldActivateButton_whenBothFieldsAreFilled() {
        // Given : 이메일 필드에 이미 텍스트가 채워져 있는 상태
        helper.input(text: "test@example.com", at: .emailId)
        // 버튼이 아직 비활성화 상태임을 확인
        XCTAssertFalse(helper.checkLoginButtonIsEnabled(), "Given 상태에서 버튼은 비활성화되어야 합니다.")
        // When : 비밀번호 필드에 첫 번째 문자를 입력하는 행위 시뮬레이션
        XCTAssertTrue(helper.textField(at: .password, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "password"), "Delegate 함수를 통한 비밀번호 입력이 성공해야 합니다.")
        // Then : 로그인 버튼이 활성화(Available) 모드로 전환되었는지 확인
        XCTAssertTrue(helper.checkLoginButtonIsEnabled(), "이메일과 비밀번호가 모두 채워졌을 때 로그인 버튼이 활성화되어야 합니다.")
    }
    
    func test_textFieldDelegateMethod_shouldReturnFalse_whenSpaceTextInputDetected() {
        // Given : 두 필드 모두 유효한 텍스트로 채워져 있어 버튼이 활성화된 상태
        helper.input(text: "test@example.com", at: .emailId)
        XCTAssertTrue(helper.textField(at: .password, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "b"), "Delegate 함수를 통한 비밀번호 입력이 성공해야 합니다.")
        XCTAssertTrue(helper.checkLoginButtonIsEnabled(), "이메일과 비밀번호가 모두 채워졌을 때 로그인 버튼이 활성화되어야 합니다.")
        // When : 비밀번호 필드의 모든 텍스트를 지우는 행위 시뮬레이션
        XCTAssertTrue(helper.textField(at: .password, shouldChangeCharactersIn: NSRange(location: 0, length: helper.passwordTextField.text?.count ?? 0), replacementString: ""), "비밀번호 필드 모두 지우기를 성공해야 합니다.")
        // Then : 로그인 버튼이 비활성화(Unavailable) 모드로 전환되었는지 확인
        XCTAssertFalse(helper.checkLoginButtonIsEnabled(), "비밀번호가 모두 지워졌을 때 로그인 버튼이 비활성화되어야 합니다.")
    }
    
    
    func test_checkLoginButtonValid_shouldActivateButton_whenBothFeildsAreFilled() {
        // Given :
        
        let currentText = "test"
        let range = NSRange(location: currentText.count, length: 0) // 끝에 공백을 추가
        let replacementString = " " // 공백 문자
        
        // 델리게이트 메서드 호출 시뮬레이션:
        let shouldChange = helper.textField(at: .emailId, shouldChangeCharactersIn: range, replacementString: replacementString)
        
        // Then : textField(_ UITextField: NSRange: String) false 반환
        XCTAssertFalse(shouldChange, "공백 입력이 감지되었을 때 false를 반환하여 입력을 막아야 합니다.")
        
        // When : 공백을 입력
        let replacementStringWithSpace = " "
        let shouldChangeWithSpace = helper.textField(at: .emailId, shouldChangeCharactersIn: range, replacementString: replacementStringWithSpace)
        
        // Then : 입력 방지 로직에 의해 false 반환을 기대
        XCTAssertFalse(shouldChangeWithSpace, "붙여넣기 등에 공백이 포함된 경우에도 false를 반환하여 입력을 막아야 합니다.")
        
    }
    
}


