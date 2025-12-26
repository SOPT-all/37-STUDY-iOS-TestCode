//
//  Operation.swift
//  CalculatorProject
//
//  Created by JIN on 12/25/25.
//

import SwiftUI

enum Operation {
    case add
    case subtract
    case multiply
    case divide
    
    var symbol: String {
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }
}
