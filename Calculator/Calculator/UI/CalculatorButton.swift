//
//  CalculatorButton.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


import Foundation

enum CalcButton: Equatable {
    case clear, toggleSign, percent, delete
    case op(Operation)
    case digit(Int)
    case dot
    case equals

    var title: String {
        switch self {
        case .clear: return "C"
        case .toggleSign: return "±"
        case .percent: return "%"
        case .delete: return "⌫"
        case .op(let op):
            switch op {
            case .add: return "+"
            case .sub: return "−"
            case .mul: return "×"
            case .div: return "÷"
            }
        case .digit(let n): return "\(n)"
        case .dot: return "."
        case .equals: return "="
        }
    }

    var a11yId: String {
        switch self {
        case .clear: return "btn_clear"
        case .toggleSign: return "btn_toggleSign"
        case .percent: return "btn_percent"
        case .delete: return "btn_delete"
        case .op(let op):
            switch op {
            case .add: return "btn_add"
            case .sub: return "btn_sub"
            case .mul: return "btn_mul"
            case .div: return "btn_div"
            }
        case .digit(let n): return "btn_\(n)"
        case .dot: return "btn_dot"
        case .equals: return "btn_equals"
        }
    }

    func toAction() -> CalculatorAction {
        switch self {
        case .clear: return .clear
        case .toggleSign: return .toggleSign
        case .percent: return .percent
        case .delete: return .delete
        case .op(let op): return .op(op)
        case .digit(let n): return .digit(n)
        case .dot: return .dot
        case .equals: return .equals
        }
    }
}
