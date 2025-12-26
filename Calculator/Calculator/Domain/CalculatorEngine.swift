//
//  CalculatorEngine.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


public protocol CalculatorEngine {
    func reduce(state: CalculatorState, action: CalculatorAction) -> CalculatorState
}