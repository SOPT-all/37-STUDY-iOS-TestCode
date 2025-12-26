//
//  CalculatorModel.swift
//  CalculatorTest
//
//  Created by 김나연 on 12/26/25.
//

import Foundation

enum CalculatorOperation {
    case add, subtract, multiply, divide, none
}

// Protocol for dependency injection
protocol CalculatorModelProtocol {
    var displayValue: String { get }
    mutating func inputNumber(_ number: String)
    mutating func inputOperation(_ operation: CalculatorOperation)
    mutating func performOperation()
    mutating func reset()
    mutating func toggleSign()
    mutating func percentage()
}

struct CalculatorModel: CalculatorModelProtocol {
    private var accumulator: Double = 0
    private var currentOperation: CalculatorOperation = .none
    private var isNewNumber: Bool = true
    
    var displayValue: String = "0"
    
    // 숫자 입력 처리
    mutating func inputNumber(_ number: String) {
        if isNewNumber {
            displayValue = number
            isNewNumber = false
        } else {
            if number == "." && displayValue.contains(".") {
                return // 소수점 중복 방지
            }
            displayValue += number
        }
    }
    
    // 연산자 입력 처리
    mutating func inputOperation(_ operation: CalculatorOperation) {
        if let currentValue = Double(displayValue) {
            if !isNewNumber {
                performOperation()
            }
            accumulator = currentValue
            currentOperation = operation
            isNewNumber = true
        }
    }
    
    // 계산 실행
    mutating func performOperation() {
        guard let currentValue = Double(displayValue) else { return }
        
        switch currentOperation {
        case .add:
            accumulator += currentValue
        case .subtract:
            accumulator -= currentValue
        case .multiply:
            accumulator *= currentValue
        case .divide:
            if currentValue != 0 {
                accumulator /= currentValue
            } else {
                displayValue = "Error"
                reset()
                return
            }
        case .none:
            accumulator = currentValue
        }
        
        displayValue = formatNumber(accumulator)
        currentOperation = .none
        isNewNumber = true
    }
    
    // 초기화
    mutating func reset() {
        accumulator = 0
        currentOperation = .none
        isNewNumber = true
        displayValue = "0"
    }
    
    // +/- 부호 변경
    mutating func toggleSign() {
        if let value = Double(displayValue) {
            displayValue = formatNumber(-value)
        }
    }
    
    // 퍼센트 계산
    mutating func percentage() {
        if let value = Double(displayValue) {
            displayValue = formatNumber(value / 100)
        }
    }
    
    // 숫자 포맷팅 (불필요한 소수점 제거)
    private func formatNumber(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", number)
        } else {
            return String(number)
        }
    }
}
