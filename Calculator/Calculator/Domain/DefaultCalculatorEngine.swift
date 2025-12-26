//
//  DefaultCalculatorEngine.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


import Foundation

public struct DefaultCalculatorEngine: CalculatorEngine {
    public init() {}

    public func reduce(state: CalculatorState, action: CalculatorAction) -> CalculatorState {
        var s = state
        s.error = nil

        switch action {
        case .clear:
            return CalculatorState()

        case .digit(let n):
            return handleDigit(&s, n)

        case .dot:
            return handleDot(&s)

        case .delete:
            return handleDelete(&s)

        case .toggleSign:
            return handleToggleSign(&s)

        case .percent:
            return handlePercent(&s)

        case .op(let op):
            return handleOp(&s, op)

        case .equals:
            return handleEquals(&s)
        }
    }
}

private extension DefaultCalculatorEngine {

    func handleDigit(_ s: inout CalculatorState, _ n: Int) -> CalculatorState {
        guard (0...9).contains(n) else { return s }

        if s.isEnteringNewNumber {
            s.entry = "\(n)"
            s.isEnteringNewNumber = false
        } else {
            if s.entry == "0" { s.entry = "\(n)" }
            else if s.entry == "-0" { s.entry = "-\(n)" }
            else { s.entry += "\(n)" }
        }
        s.display = s.entry
        return s
    }

    func handleDot(_ s: inout CalculatorState) -> CalculatorState {
        if s.isEnteringNewNumber {
            s.entry = "0."
            s.isEnteringNewNumber = false
        } else if !s.entry.contains(".") {
            s.entry += "."
        }
        s.display = s.entry
        return s
    }

    func handleDelete(_ s: inout CalculatorState) -> CalculatorState {
        guard !s.isEnteringNewNumber else { return s }

        if s.entry.count <= 1 || (s.entry.count == 2 && s.entry.hasPrefix("-")) {
            s.entry = "0"
            s.isEnteringNewNumber = true
        } else {
            s.entry.removeLast()
            if s.entry.last == "." { s.entry.removeLast() } // "12." 방지
            if s.entry == "-" { s.entry = "0"; s.isEnteringNewNumber = true }
        }
        s.display = s.entry
        return s
    }

    func handleToggleSign(_ s: inout CalculatorState) -> CalculatorState {
        if s.entry == "0" { return s }
        if s.entry.hasPrefix("-") { s.entry.removeFirst() }
        else { s.entry = "-" + s.entry }
        s.display = s.entry
        return s
    }

    func handlePercent(_ s: inout CalculatorState) -> CalculatorState {
        guard let v = Decimal(string: s.entry) else { return s }
        let r = v / 100
        s.entry = format(r)
        s.display = s.entry
        return s
    }

    func handleOp(_ s: inout CalculatorState, _ op: Operation) -> CalculatorState {
        guard let current = Decimal(string: s.entry) else { return s }

        if s.accumulator == nil {
            s.accumulator = current
        } else if let acc = s.accumulator, let pending = s.pendingOp, !s.isEnteringNewNumber {
            guard let result = apply(pending, acc, current) else { return setError(&s) }
            s.accumulator = result
            s.entry = format(result)
            s.display = s.entry
        } else {

        }

        s.pendingOp = op
        s.isEnteringNewNumber = true
        return s
    }

    func handleEquals(_ s: inout CalculatorState) -> CalculatorState {
        guard let acc = s.accumulator, let pending = s.pendingOp else {
            s.display = s.entry
            s.isEnteringNewNumber = true
            return s
        }
        guard let current = Decimal(string: s.entry) else { return s }

        guard let result = apply(pending, acc, current) else { return setError(&s) }
        s.accumulator = result
        s.pendingOp = nil
        s.entry = format(result)
        s.display = s.entry
        s.isEnteringNewNumber = true
        return s
    }

    func apply(_ op: Operation, _ a: Decimal, _ b: Decimal) -> Decimal? {
        switch op {
        case .add: return a + b
        case .sub: return a - b
        case .mul: return a * b
        case .div:
            if b == 0 { return nil }
            return a / b
        }
    }

    func setError(_ s: inout CalculatorState) -> CalculatorState {
        s.error = "Error"
        s.display = "Error"
        s.entry = "0"
        s.accumulator = nil
        s.pendingOp = nil
        s.isEnteringNewNumber = true
        return s
    }

    func format(_ d: Decimal) -> String {
        let ns = d as NSDecimalNumber
        var str = ns.stringValue

        if str == "-0" { str = "0" }
        return str
    }
}
