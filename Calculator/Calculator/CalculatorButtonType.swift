//
//  CalculatorButtonType.swift
//  Calculator
//
//  Created by 김호성 on 2025.12.26.
//

import SwiftUI

enum CalculatorButtonType {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case add, subtract, multiply, divide, modular
    case equal
    case decimal, sign
    case erase, clear
}

extension CalculatorButtonType {
    var title: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "*"
        case .divide:
            return "/"
        case .modular:
            return "%"
        case .equal:
            return "="
        case .decimal:
            return "."
        case .sign:
            return "±"
        case .erase:
            return "<x"
        case .clear:
            return "C"
        }
    }
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .sign, .decimal:
            return Color(hex: 0x45474B)
        case .equal, .add, .subtract, .multiply, .divide:
            return Color(hex: 0xFF9200)
        case .erase, .clear, .modular:
            return Color(hex: 0x707376)
        }
    }
}
