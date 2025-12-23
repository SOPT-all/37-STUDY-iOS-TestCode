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
        switch `operator` {
        case .add:
            return lhs + rhs
        case .subtract:
            return lhs - rhs
        case .multiply:
            return lhs * rhs
        case .divide:
            // Edge Case
            // nan : Not a Number를 의미, 무한도 쓸 수 있다.
            return rhs == 0 ? Double.nan : lhs / rhs
        }
    }
}
