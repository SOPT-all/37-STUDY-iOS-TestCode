//
//  CalculatorButton.swift
//  Calculator
//
//  Created by sun on 12/26/25.
//

import UIKit

enum CalculatorButton: Hashable {
    case clear
    case sign
    case percent
    case operation(Operation)
    case digit(Int)
    case decimal
    case equals

    enum Operation: String, CaseIterable {
        case add = "+"
        case subtract = "−"
        case multiply = "×"
        case divide = "÷"
    }

    var title: String {
        switch self {
        case .clear: return "AC"
        case .sign: return "±"
        case .percent: return "%"
        case .operation(let op): return op.rawValue
        case .digit(let n): return "\(n)"
        case .decimal: return "."
        case .equals: return "="
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .operation, .equals:
            return .systemOrange
        case .clear, .sign, .percent:
            return .systemGray2
        case .digit, .decimal:
            return .systemGray4
        }
    }

    var titleColor: UIColor {
        switch self {
        case .clear, .sign, .percent:
            return .label
        default:
            return .white
        }
    }
}
