//
//  CalculatorTypes.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


import Foundation

public enum Operation: Equatable {
    case add, sub, mul, div
}

public enum CalculatorAction: Equatable {
    case digit(Int)
    case dot
    case op(Operation)
    case equals
    case clear
    case delete
    case toggleSign
    case percent
}

public struct CalculatorState: Equatable {
    public var display: String = "0"

    public var entry: String = "0"

    public var accumulator: Decimal? = nil

    public var pendingOp: Operation? = nil

    public var isEnteringNewNumber: Bool = true

    public var error: String? = nil

    public init() {}
}
