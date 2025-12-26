//
//  CalculatorViewModel.swift
//  CalculatorProject
//
//  Created by JIN on 12/26/25.
//

import Foundation
import Combine

final class CalculatorViewModel: ObservableObject {
    @Published private(set) var state: CalculatorState
    private let calculator: CalculatorProtocol

    var displayValue: String {
        formatNumber(state.currentValue)
    }

    init(calculator: CalculatorProtocol) {
        self.calculator = calculator
        self.state = CalculatorState()
    }

    func buttonPressed(_ button: CalculatorButton) {
        switch button {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            handleNumberInput(button)
        case .add, .subtract, .multiply, .divide:
            handleOperation(button)
        case .equal:
            handleEqual()
        case .clear:
            handleClear()
        }
    }

    // MARK: - Private Methods

    private func handleNumberInput(_ button: CalculatorButton) {
        guard let number = button.number else { return }

        if state.isNewInput {
            state.currentValue = Double(number)
            state.isNewInput = false
        } else {
            let currentString = String(Int(state.currentValue))
            let newString = currentString + String(number)
            state.currentValue = Double(newString) ?? state.currentValue
        }
    }

    private func handleOperation(_ button: CalculatorButton) {
        guard let operation = button.operation else { return }

        if let storedValue = state.storedValue,
           let currentOperation = state.currentOperation,
           !state.isNewInput {
            let result = calculator.calculate(
                lhs: storedValue,
                rhs: state.currentValue,
                operation: currentOperation
            )
            state.currentValue = result
        }
        state.storedValue = state.currentValue
        state.currentOperation = operation
        state.isNewInput = true
    }

    private func handleEqual() {
        guard let storedValue = state.storedValue,
              let operation = state.currentOperation else {
            return
        }

        let result = calculator.calculate(
            lhs: storedValue,
            rhs: state.currentValue,
            operation: operation
        )

        state.currentValue = result
        state.storedValue = nil
        state.currentOperation = nil
        state.isNewInput = true
    }

    private func handleClear() {
        state.reset()
    }

    private func formatNumber(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
}
