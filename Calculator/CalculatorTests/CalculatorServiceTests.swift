//
//  CalculatorServiceTests.swift
//  Calculator
//
//  Created by sun on 12/26/25.
//

import XCTest
@testable import Calculator

final class CalculatorServiceTests: XCTestCase {

    func test_add() {
        // Given
        let sut = CalculatorService()

        // When
        sut.inputDigit(2)
        sut.setOperation(.add)
        sut.inputDigit(3)
        sut.equals()

        // Then
        XCTAssertEqual(sut.displayText, "5")
    }
}
