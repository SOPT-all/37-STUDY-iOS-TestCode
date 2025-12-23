//
//  CalculatorService.swift
//  SOPT-Test-Code-Study
//
//  Created by 이승준 on 12/23/25.
//

import Foundation

protocol CalculatorServiceType {
    func calculate(lhs: Double, rhs: Double, operator: CalcOperator) -> Double
}

class CalculatorService: CalculatorServiceType {
    func calculate(lhs: Double, rhs: Double, operator: CalcOperator) -> Double {
        // 실제 사칙연산 로직 구현
        return 0
    }
}
