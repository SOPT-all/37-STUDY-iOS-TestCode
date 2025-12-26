//
//  Calculator.swift
//  CalculatorProject
//
//  Created by JIN on 12/25/25.
//

import SwiftUI

// MARK: - Protocol
protocol CalculatorProtocol {
    func calculate(lhs: Double, rhs: Double, operation: Operation) -> Double
}

// MARK: - Implementation
final class Calculator: CalculatorProtocol {
    func calculate(lhs: Double, rhs: Double, operation: Operation) -> Double {
        switch operation {
        case .add:
            return lhs + rhs
        case .subtract:
            return lhs - rhs
        case .multiply:
            return lhs * rhs
        case .divide:
            return rhs != 0 ? lhs / rhs : 0
        }
    }
}
