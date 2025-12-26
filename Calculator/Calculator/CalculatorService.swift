//
//  CalculatorService.swift
//  Calculator
//
//  Created by sun on 12/26/25.
//

import Foundation

protocol CalculatorServicing {
    var displayText: String { get }

    func inputDigit(_ digit: Int)
    func inputDecimal()
    func clear()
    func setOperation(_ op: CalculatorButton.Operation)
    func equals()

    func toggleSign()
    func percent()
}

extension CalculatorServicing {
    func toggleSign() {}
    func percent() {}
}

final class CalculatorService: CalculatorServicing {

    private enum State {
        case enteringLeft
        case enteringRight
        case showingResult
    }

    private(set) var displayText: String = "0"

    private var state: State = .enteringLeft

    private var leftInput: String = "0"
    private var rightInput: String = "0"
    private var operation: CalculatorButton.Operation?

    private let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.numberStyle = .decimal
        f.maximumFractionDigits = 9
        f.minimumFractionDigits = 0
        f.usesGroupingSeparator = false
        return f
    }()

    init() {
        syncDisplay()
    }

    func inputDigit(_ digit: Int) {
        guard (0...9).contains(digit) else { return }
        guard displayText != "Error" else { return }

        switch state {
        case .enteringLeft:
            leftInput = appendDigit(to: leftInput, digit: digit)
            syncDisplay(from: leftInput)

        case .enteringRight:
            rightInput = appendDigit(to: rightInput, digit: digit)
            syncDisplay(from: rightInput)

        case .showingResult:
            clear()
            leftInput = appendDigit(to: leftInput, digit: digit)
            syncDisplay(from: leftInput)
        }
    }

    func inputDecimal() {
        return
    }

    func clear() {
        state = .enteringLeft
        leftInput = "0"
        rightInput = "0"
        operation = nil
        syncDisplay()
    }

    func setOperation(_ op: CalculatorButton.Operation) {
        guard displayText != "Error" else { return }
        operation = op
        state = .enteringRight
        rightInput = "0"
        syncDisplay(from: leftInput)
    }

    func equals() {
        guard displayText != "Error" else { return }
        guard let op = operation else { return }

        let lhs = Decimal(string: leftInput) ?? 0
        let rhs = Decimal(string: rightInput) ?? 0

        let result: Decimal?
        switch op {
        case .add: result = lhs + rhs
        case .subtract: result = lhs - rhs
        case .multiply: result = lhs * rhs
        case .divide:
            result = (rhs == 0) ? nil : (lhs / rhs)
        }

        if let result {
            let plain = (result as NSDecimalNumber).stringValue
            leftInput = plain
            rightInput = "0"
            operation = nil
            state = .showingResult
            syncDisplay(from: leftInput)
        } else {
            displayText = "Error"
        }
    }

    // MARK: - Helpers

    private func appendDigit(to input: String, digit: Int) -> String {
        if input == "0" { return "\(digit)" }
        return input + "\(digit)"
    }

    private func syncDisplay() {
        syncDisplay(from: leftInput)
    }

    private func syncDisplay(from input: String) {
        let value = Decimal(string: input) ?? 0
        displayText = formatter.string(from: value as NSDecimalNumber) ?? input
    }
}
