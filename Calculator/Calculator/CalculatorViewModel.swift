//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by 김호성 on 2025.12.26.
//

import Foundation
import Combine

enum CalculateState {
    enum Operator {
        case add
        case subtract
        case multiply
        case divide
        case modular
    }
    case num(Int)
    case `operator`(Operator)
    
    var text: String {
        switch self {
        case .num(let int):
            return "\(int)"
        case .operator(let `operator`):
            switch `operator` {
            case .add:
                return "+"
            case .subtract:
                return "-"
            case .multiply:
                return "*"
            case .divide:
                return "/"
            case .modular:
                return "%"
            }
        }
    }
}

final class CalculatorViewModel: ObservableObject {
    
    @Published var stack: [CalculateState] = []
    
    func buttonTapped(_ type: CalculatorButtonType) {
        switch type {
        case .zero:
            guard let last = stack.last else { return }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10))
            case .operator:
                return
            }
        case .one:
            guard let last = stack.last else {
                stack.append(.num(1))
                return
            }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10 + 1))
            case .operator:
                stack.append(.num(1))
            }
        case .two:
            guard let last = stack.last else {
                stack.append(.num(2))
                return
            }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10 + 2))
            case .operator:
                stack.append(.num(2))
            }
        case .three:
            guard let last = stack.last else {
                stack.append(.num(3))
                return
            }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10 + 3))
            case .operator:
                stack.append(.num(3))
            }
        case .four:
            guard let last = stack.last else {
                stack.append(.num(4))
                return
            }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10 + 4))
            case .operator:
                stack.append(.num(4))
            }
        case .five:
            guard let last = stack.last else {
                stack.append(.num(5))
                return
            }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10 + 5))
            case .operator:
                stack.append(.num(5))
            }
        case .six:
            guard let last = stack.last else {
                stack.append(.num(6))
                return
            }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10 + 6))
            case .operator:
                stack.append(.num(6))
            }
        case .seven:
            guard let last = stack.last else {
                stack.append(.num(7))
                return
            }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10 + 7))
            case .operator:
                stack.append(.num(7))
            }
        case .eight:
            guard let last = stack.last else {
                stack.append(.num(8))
                return
            }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10 + 8))
            case .operator:
                stack.append(.num(8))
            }
        case .nine:
            guard let last = stack.last else {
                stack.append(.num(9))
                return
            }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int*10 + 9))
            case .operator:
                stack.append(.num(9))
            }
        case .add:
            guard let last = stack.last else { return }
            if case .num = last {
                stack.append(.operator(.add))
            }
        case .subtract:
            guard let last = stack.last else { return }
            if case .num = last {
                stack.append(.operator(.subtract))
            }
        case .multiply:
            guard let last = stack.last else { return }
            if case .num = last {
                stack.append(.operator(.multiply))
            }
        case .divide:
            guard let last = stack.last else { return }
            if case .num = last {
                stack.append(.operator(.divide))
            }
        case .modular:
            guard let last = stack.last else { return }
            if case .num = last {
                stack.append(.operator(.modular))
            }
        case .equal:
            var result: Int = 0
            var nowOperator: CalculateState.Operator?
            
            for state in stack {
                switch state {
                case .num(let int):
                    if let nowOperator {
                        switch nowOperator {
                        case .add:
                            result += int
                        case .subtract:
                            result -= int
                        case .multiply:
                            result *= int
                        case .divide:
                            result /= int
                        case .modular:
                            result %= int
                        }
                    } else {
                        result = int
                    }
                case .operator(let `operator`):
                    nowOperator = `operator`
                }
            }
            stack = [.num(result)]
        case .decimal:
            return
        case .sign:
            return
        case .erase:
            guard let last = stack.last else { return }
            switch last {
            case .num(let int):
                _ = stack.popLast()
                stack.append(.num(int / 10))
            case .operator:
                _ = stack.popLast()
            }
        case .clear:
            stack.removeAll()
        }
        
        print(stack)
    }
}
