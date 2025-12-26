//
//  Button.swift
//  CalculatorProject
//
//  Created by JIN on 12/25/25.
//

import SwiftUI

enum CalculatorButton: Hashable {
    case zero, one, two, three, four
    case five, six, seven, eight, nine
    
    case add
    case subtract
    case multiply
    case divide
    
    case equal
    case clear
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .equal: return "="
        case .clear: return "AC"
        }
    }
    
    var number: Int? {
        switch self {
        case .zero: return 0
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        default: return nil
        }
    }
    
    var operation: Operation? {
        switch self {
        case .add: return .add
        case .subtract: return .subtract
        case .multiply: return .multiply
        case .divide: return .divide
        default: return nil
        }
    }
}
