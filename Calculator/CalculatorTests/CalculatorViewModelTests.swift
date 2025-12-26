//
//  CalculatorViewModelTests.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


import XCTest

@testable import CalculatorApp

private struct StubEngine: CalculatorEngine {
    func reduce(state: CalculatorState, action: CalculatorAction) -> CalculatorState {
        var s = state
        s.display = "stub"
        return s
    }
}

@MainActor
final class CalculatorViewModelTests: XCTestCase {

    func test_send_updatesPublishedState() {
        let vm = CalculatorViewModel(engine: StubEngine())
        vm.send(.digit(1))
        XCTAssertEqual(vm.state.display, "stub")
    }
}
