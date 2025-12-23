//
//  CalculatorServiceTests.swift
//  SOPT-Test-Code-StudyTests
//
//  Created by 이승준 on 12/23/25.
//

import XCTest
import Combine
@testable import SOPT_Test_Code_Study

final class CalculatorServiceTests: XCTestCase {
    
    private var sut: CalculatorService!

    override func setUp() {
        super.setUp()
        sut = CalculatorService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - 일반 케이스 (Normal Cases)

    func test_add_1And2_returns3() {
        // given
        let lhs = 1.0
        let rhs = 2.0
        
        // when
        let result = sut.calculate(lhs: lhs, rhs: rhs, operator: .add)
        
        // then
        XCTAssertEqual(result, 3.0, "1 + 2는 3이어야 합니다.")
    }

    func test_subtract_5And2_returns3() {
        // given
        let lhs = 5.0
        let rhs = 2.0
        
        // when
        let result = sut.calculate(lhs: lhs, rhs: rhs, operator: .subtract)
        
        // then
        XCTAssertEqual(result, 3.0, "5 - 2는 3이어야 합니다.")
    }

    func test_multiply_4And3_returns12() {
        // given
        let lhs = 4.0
        let rhs = 3.0
        
        // when
        let result = sut.calculate(lhs: lhs, rhs: rhs, operator: .multiply)
        
        // then
        XCTAssertEqual(result, 12.0, "4 * 3은 12여야 합니다.")
    }

    func test_divide_10By2_returns5() {
        // given
        let lhs = 10.0
        let rhs = 2.0
        
        // when
        let result = sut.calculate(lhs: lhs, rhs: rhs, operator: .divide)
        
        // then
        XCTAssertEqual(result, 5.0, "10 / 2는 5여야 합니다.")
    }

    // MARK: - 엣지 케이스 (Edge Cases)

    func test_divide_byZero_returnsNaN() {
        // given
        let lhs = 10.0
        let rhs = 0.0
        
        // when
        let result = sut.calculate(lhs: lhs, rhs: rhs, operator: .divide)
        
        // then
        // NaN은 '==' 비교가 불가능하므로 isNaN 프로퍼티를 사용합니다.
        XCTAssertTrue(result.isNaN, "0으로 나누면 NaN(Not a Number)이 반환되어야 합니다.")
    }
}
