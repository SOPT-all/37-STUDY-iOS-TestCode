//
//  CalculatorViewModel.swift
//  CalculatorTest
//
//  Created by 김나연 on 12/26/25.
//

import SwiftUI
import Combine

class CalculatorViewModel: ObservableObject {
    @Published private(set) var displayText: String = "0"
    
    private var model: CalculatorModelProtocol
    
    init(model: CalculatorModelProtocol = CalculatorModel()) {
        self.model = model
        updateDisplay()
    }
    
    func buttonTapped(_ button: CalculatorButton) {
        switch button {
        case .digit(let number):
            model.inputNumber(String(number))
        case .decimal:
            model.inputNumber(".")
        case .operation(let op):
            model.inputOperation(op)
        case .equals:
            model.performOperation()
        case .clear:
            model.reset()
        case .toggleSign:
            model.toggleSign()
        case .percentage:
            model.percentage()
        }
        
        updateDisplay()
    }
    
    private func updateDisplay() {
        displayText = model.displayValue
    }
}

// 계산기 버튼 타입 정의
enum CalculatorButton: Equatable {
    case digit(Int)
    case decimal
    case operation(CalculatorOperation)
    case equals
    case clear
    case toggleSign
    case percentage
    
    var title: String {
        switch self {
        case .digit(let number):
            return "\(number)"
        case .decimal:
            return "."
        case .operation(let op):
            switch op {
            case .add: return "+"
            case .subtract: return "-"
            case .multiply: return "×"
            case .divide: return "÷"
            case .none: return ""
            }
        case .equals:
            return "="
        case .clear:
            return "AC"
        case .toggleSign:
            return "±"
        case .percentage:
            return "%"
        }
    }
    
    var backgroundColor: String {
        switch self {
        case .operation, .equals:
            return "orange"
        case .clear, .toggleSign, .percentage:
            return "lightGray"
        default:
            return "darkGray"
        }
    }
}
