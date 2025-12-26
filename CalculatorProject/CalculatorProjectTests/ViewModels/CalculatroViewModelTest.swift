//
//  CalculatroViewModelTest.swift
//  CalculatorProjectTests
//
//  Created by JIN on 12/26/25.
//

import XCTest
@testable import CalculatorProject

final class CalculatorViewModelTests: XCTestCase {
    var sut: CalculatorViewModel!
    var mockCalculator: Calculator!

    override func setUp() {
        super.setUp()
        mockCalculator = Calculator()
        sut = CalculatorViewModel(calculator: mockCalculator)
    }

    override func tearDown() {
        sut = nil
        mockCalculator = nil
        super.tearDown()
    }

    // MARK: - Initial State Tests

    func test_initialState_shouldDisplayZero() {
        XCTAssertEqual(sut.displayValue, "0")
    }

    // MARK: - Number Input Tests

    func test_pressNumberButton_shouldUpdateDisplay() {
        sut.buttonPressed(.two)
        XCTAssertEqual(sut.displayValue, "2")
    }

    func test_pressMultipleNumbers_shouldConcatenate() {
        sut.buttonPressed(.two)
        sut.buttonPressed(.four)
        XCTAssertEqual(sut.displayValue, "24")
    }

    // MARK: - Operation Tests

    func test_pressAddOperation_shouldStoreValueAndOperation() {
        sut.buttonPressed(.two)
        sut.buttonPressed(.four)
        sut.buttonPressed(.add)
        XCTAssertEqual(sut.displayValue, "24")
    }

    func test_afterOperation_newNumberShouldReplaceDisplay() {
        sut.buttonPressed(.two)
        sut.buttonPressed(.four)
        sut.buttonPressed(.add)
        sut.buttonPressed(.three)
        XCTAssertEqual(sut.displayValue, "3")
    }

    // MARK: - Continuous Calculation Tests

    func test_continuousCalculation_24plus36plus20_shouldEqual80() {
        sut.buttonPressed(.two)
        sut.buttonPressed(.four)
        XCTAssertEqual(sut.displayValue, "24")
        sut.buttonPressed(.add)
        XCTAssertEqual(sut.displayValue, "24")
        sut.buttonPressed(.three)
        sut.buttonPressed(.six)
        XCTAssertEqual(sut.displayValue, "36")
        sut.buttonPressed(.add)
        XCTAssertEqual(sut.displayValue, "60")
        sut.buttonPressed(.two)
        sut.buttonPressed(.zero)
        XCTAssertEqual(sut.displayValue, "20")
        sut.buttonPressed(.equal)
        XCTAssertEqual(sut.displayValue, "80")
    }

    // MARK: - Equal Operation Tests

    func test_simpleAddition_shouldCalculateCorrectly() {
        sut.buttonPressed(.two)
        sut.buttonPressed(.four)
        sut.buttonPressed(.add)
        sut.buttonPressed(.three)
        sut.buttonPressed(.six)
        sut.buttonPressed(.equal)
        XCTAssertEqual(sut.displayValue, "60")
    }

    func test_simpleSubtraction_shouldCalculateCorrectly() {
        sut.buttonPressed(.five)
        sut.buttonPressed(.zero)
        sut.buttonPressed(.subtract)
        sut.buttonPressed(.three)
        sut.buttonPressed(.zero)
        sut.buttonPressed(.equal)
        XCTAssertEqual(sut.displayValue, "20")
    }

    func test_simpleMultiplication_shouldCalculateCorrectly() {
        sut.buttonPressed(.one)
        sut.buttonPressed(.two)
        sut.buttonPressed(.multiply)
        sut.buttonPressed(.five)
        sut.buttonPressed(.equal)
        XCTAssertEqual(sut.displayValue, "60")
    }

    func test_simpleDivision_shouldCalculateCorrectly() {
        sut.buttonPressed(.eight)
        sut.buttonPressed(.zero)
        sut.buttonPressed(.divide)
        sut.buttonPressed(.four)
        sut.buttonPressed(.equal)
        XCTAssertEqual(sut.displayValue, "20")
    }

    // MARK: - Clear Operation Tests

    func test_clearButton_shouldResetToInitialState() {
        sut.buttonPressed(.two)
        sut.buttonPressed(.four)
        sut.buttonPressed(.add)
        sut.buttonPressed(.three)
        sut.buttonPressed(.six)
        sut.buttonPressed(.clear)
        XCTAssertEqual(sut.displayValue, "0")
    }

    func test_clearButton_afterClear_canStartNewCalculation() {
        sut.buttonPressed(.five)
        sut.buttonPressed(.clear)
        sut.buttonPressed(.three)
        XCTAssertEqual(sut.displayValue, "3")
    }
}
