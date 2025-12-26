//
//  CalculatorProjectTests.swift
//  CalculatorProjectTests
//
//  Created by JIN on 12/25/25.
//

import XCTest
@testable import CalculatorProject

final class CalculatorProjectTests: XCTestCase {
    
    var sut: Calculator!
    
    override func setUp() {
        super.setUp()
        sut = Calculator()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Addition Tests
    func test_calculate_whenAddingTwoAndThree_returnsFive() {
        let lhs = 2.0
        let rhs = 3.0

        let result = sut.calculate(lhs: lhs, rhs: rhs, operation: .add)

        XCTAssertEqual(result, 5.0)
    }

    func test_calculate_whenAddingNegativeAndPositive_returnsCorrectSum() {
        let lhs = -5.0
        let rhs = 3.0

        let result = sut.calculate(lhs: lhs, rhs: rhs, operation: .add)

        XCTAssertEqual(result, -2.0)
    }
    
    // MARK: - Subtraction Tests
    func test_calculate_whenSubtractingThreeFromFive_returnsTwo() {
        let lhs = 5.0
        let rhs = 3.0

        let result = sut.calculate(lhs: lhs, rhs: rhs, operation: .subtract)

        XCTAssertEqual(result, 2.0)
    }

    func test_calculate_whenSubtractingLargerFromSmaller_returnsNegativeResult() {
        let lhs = 3.0
        let rhs = 5.0

        let result = sut.calculate(lhs: lhs, rhs: rhs, operation: .subtract)

        XCTAssertEqual(result, -2.0)
    }
    
    // MARK: - Multiplication Tests
    
    func test_calculate_whenMultiplyingFourAndThree_returnsTwelve() {
        let lhs = 4.0
        let rhs = 3.0

        let result = sut.calculate(lhs: lhs, rhs: rhs, operation: .multiply)

        XCTAssertEqual(result, 12.0)
    }

    func test_calculate_whenMultiplyingByZero_returnsZero() {
        let lhs = 0.0
        let rhs = 5.0

        let result = sut.calculate(lhs: lhs, rhs: rhs, operation: .multiply)

        XCTAssertEqual(result, 0.0)
    }
    
    func test_calculate_whenDividingTenByTwo_returnsFive() {
        let lhs = 10.0
        let rhs = 2.0

        let result = sut.calculate(lhs: lhs, rhs: rhs, operation: .divide)

        XCTAssertEqual(result, 5.0)
    }

    func test_calculate_whenDividingByZero_returnsZero() {
        let lhs = 10.0
        let rhs = 0.0

        let result = sut.calculate(lhs: lhs, rhs: rhs, operation: .divide)

        XCTAssertEqual(result, 0.0)
    }
}
