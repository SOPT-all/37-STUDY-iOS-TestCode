//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by sun on 12/26/25.
//

import Foundation

final class CalculatorViewModel {

    struct Output: Equatable {
        var displayText: String
    }

    private let service: CalculatorServicing

    private(set) var output: Output {
        didSet { onOutputChanged?(output) }
    }

    var onOutputChanged: ((Output) -> Void)?

    init(service: CalculatorServicing) {
        self.service = service
        self.output = Output(displayText: service.displayText)
    }

    func onTap(_ button: CalculatorButton) {
        switch button {
        case .digit(let n):
            service.inputDigit(n)
        case .decimal:
            service.inputDecimal()
        case .clear:
            service.clear()
        case .sign:
            service.toggleSign()
        case .percent:
            service.percent()
        case .operation(let op):
            service.setOperation(op)
        case .equals:
            service.equals()
        }

        output = Output(displayText: service.displayText)
    }
}
