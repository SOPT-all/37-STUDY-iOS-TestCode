//
//  LoginViewControllerTests.swift
//  spot-37th-assignmentTests
//
//  Created by 어재선 on 11/15/25.
//

import XCTest
@testable import spot_37th_assignment


final class LoginViewControllerTests: XCTestCase {
    
    var sut: LoginViewController!  // sut = System Under Test (테스트 대상)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        // 각 테스트 전에 새로운 LoginViewController 인스턴스 생성
        sut = LoginViewController()
        
        // View를 메모리에 로드 (viewDidLoad 호출됨)
        sut.loadViewIfNeeded()
        
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - 이메일 유효성 검사 테스트
    
    func testValidEmail() {
        // Given: 유효한 이메일
        let email = "jaesun@inha.ac.kr"
        
        // When: 이메일 유효성 검사
        let result = sut.isValidEmail(email: email)
        
        // Then: true를 반환해야 함
        XCTAssertTrue(result, "유효한 이메일 형식이 true를 반환해야 합니다")
    }
    
    func testValidEmailWithGmailDomain() {
        // Given
        let email = "test@gmail.com"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertTrue(result, "Gmail 형식이 유효해야 합니다")
    }
    
    func testValidEmailWithUnderscore() {
        // Given
        let email = "test_user@example.com"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertTrue(result, "언더스코어가 포함된 이메일이 유효해야 합니다")
    }
    
    func testValidEmailWithDot() {
        // Given
        let email = "test.user@example.com"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertTrue(result, "점이 포함된 이메일이 유효해야 합니다")
    }
    
    func testValidEmailWithNumbers() {
        // Given
        let email = "user123@example.com"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertTrue(result, "숫자가 포함된 이메일이 유효해야 합니다")
    }
    
    func testInvalidEmailWithoutAtSign() {
        // Given: @ 기호가 없는 이메일
        let email = "jaesuninha.ac.kr"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then: false를 반환해야 함
        XCTAssertFalse(result, "@ 기호가 없는 이메일은 false를 반환해야 합니다")
    }
    
    func testInvalidEmailWithoutDomain() {
        // Given
        let email = "jaesun@"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "도메인이 없는 이메일은 false를 반환해야 합니다")
    }
    
    func testInvalidEmailWithoutExtension() {
        // Given
        let email = "jaesun@inha"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "확장자가 없는 이메일은 false를 반환해야 합니다")
    }
    
    func testInvalidEmailWithoutLocalPart() {
        // Given
        let email = "@inha.ac.kr"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "로컬 부분이 없는 이메일은 false를 반환해야 합니다")
    }
    
    func testInvalidEmailWithEmptyString() {
        // Given
        let email = ""
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "빈 문자열은 false를 반환해야 합니다")
    }
    
    func testInvalidEmailWithSpace() {
        // Given
        let email = "jaesun @inha.ac.kr"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "공백이 포함된 이메일은 false를 반환해야 합니다")
    }
    
    func testInvalidEmailWithMultipleAtSigns() {
        // Given
        let email = "jaesun@@inha.ac.kr"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "여러 개의 @ 기호는 false를 반환해야 합니다")
    }
    
    func testInvalidEmailStartingWithDot() {
        // Given
        let email = ".jaesun@inha.ac.kr"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "점으로 시작하는 이메일은 false를 반환해야 합니다")
    }
    
    func testInvalidEmailEndingWithDot() {
        // Given
        let email = "jaesun.@inha.ac.kr"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "점으로 끝나는 이메일은 false를 반환해야 합니다")
    }
    
    func testInvalidEmailWithConsecutiveDots() {
        // Given
        let email = "jae..sun@inha.ac.kr"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "연속된 점이 있는 이메일은 false를 반환해야 합니다")
    }
    
    func testInvalidEmailWithSpecialCharacters() {
        // Given
        let email = "jaesun#$%@inha.ac.kr"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertFalse(result, "허용되지 않은 특수문자는 false를 반환해야 합니다")
    }
    
    // MARK: - Edge Cases (경계 케이스)
    
    func testEmailWithMinimumLength() {
        // Given: 최소 길이의 유효한 이메일
        let email = "a@b.co"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertTrue(result, "최소 길이의 유효한 이메일이어야 합니다")
    }
    
    func testEmailWithLongExtension() {
        // Given: 긴 확장자를 가진 이메일
        let email = "test@example.museum"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertTrue(result, "긴 확장자를 가진 이메일이 유효해야 합니다")
    }
    
    func testEmailWithSubdomain() {
        // Given
        let email = "test@mail.example.com"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertTrue(result, "서브도메인을 포함한 이메일이 유효해야 합니다")
    }
    
    // MARK: - 실제 사용 케이스 테스트
    
    func testBaeminDomainEmail() {
        // Given: 배민 실제 도메인
        let email = "developer@woowahan.com"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertTrue(result, "배민 도메인 이메일이 유효해야 합니다")
    }
    
    func testSOPTDomainEmail() {
        // Given
        let email = "jaesun@sopt.org"
        
        // When
        let result = sut.isValidEmail(email: email)
        
        // Then
        XCTAssertTrue(result, "SOPT 도메인 이메일이 유효해야 합니다")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
