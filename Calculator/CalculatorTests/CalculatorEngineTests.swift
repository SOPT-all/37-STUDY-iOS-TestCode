//
//  CalculatorEngineTests.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


import XCTest

@testable import CalculatorApp

final class CalculatorEngineTests: XCTestCase {

    func test_1_plus_2_equals_3() {
        let engine = DefaultCalculatorEngine()
        var s = CalculatorState()

        s = engine.reduce(state: s, action: .digit(1))
        s = engine.reduce(state: s, action: .op(.add))
        s = engine.reduce(state: s, action: .digit(2))
        s = engine.reduce(state: s, action: .equals)

        XCTAssertEqual(s.display, "3")
    }

    func test_leftToRight_2_plus_3_mul_4_equals_20() {
        let engine = DefaultCalculatorEngine()
        var s = CalculatorState()

        s = engine.reduce(state: s, action: .digit(2))
        s = engine.reduce(state: s, action: .op(.add))
        s = engine.reduce(state: s, action: .digit(3))
        s = engine.reduce(state: s, action: .op(.mul)) // 즉시 계산으로 여기서 5가 됨
        XCTAssertEqual(s.display, "5")

        s = engine.reduce(state: s, action: .digit(4))
        s = engine.reduce(state: s, action: .equals)
        XCTAssertEqual(s.display, "20")
    }

    func test_operatorReplacement_whenOpTappedTwice_onlyPendingChanges() {
        let engine = DefaultCalculatorEngine()
        var s = CalculatorState()

        s = engine.reduce(state: s, action: .digit(9))
        s = engine.reduce(state: s, action: .op(.add))
        s = engine.reduce(state: s, action: .op(.mul)) // 숫자 입력 없이 op만 교체
        s = engine.reduce(state: s, action: .digit(2))
        s = engine.reduce(state: s, action: .equals)

        XCTAssertEqual(s.display, "18") // 9 * 2
    }

    func test_divideByZero_showsError() {
        let engine = DefaultCalculatorEngine()
        var s = CalculatorState()

        s = engine.reduce(state: s, action: .digit(8))
        s = engine.reduce(state: s, action: .op(.div))
        s = engine.reduce(state: s, action: .digit(0))
        s = engine.reduce(state: s, action: .equals)

        XCTAssertEqual(s.display, "Error")
        XCTAssertEqual(s.error, "Error")
    }

    func test_dotInput() {
        let engine = DefaultCalculatorEngine()
        var s = CalculatorState()

        s = engine.reduce(state: s, action: .digit(1))
        s = engine.reduce(state: s, action: .dot)
        s = engine.reduce(state: s, action: .digit(5))

        XCTAssertEqual(s.display, "1.5")
    }

    func test_toggleSign() {
        let engine = DefaultCalculatorEngine()
        var s = CalculatorState()

        s = engine.reduce(state: s, action: .digit(9))
        s = engine.reduce(state: s, action: .toggleSign)

        XCTAssertEqual(s.display, "-9")
    }

    func test_percent() {
        let engine = DefaultCalculatorEngine()
        var s = CalculatorState()

        s = engine.reduce(state: s, action: .digit(5))
        s = engine.reduce(state: s, action: .digit(0))
        s = engine.reduce(state: s, action: .percent)

        XCTAssertEqual(s.display, "0.5")
    }
}
