//
//  CalculatorViewModel.swift
//  SOPT-Test-Code-Study
//
//  Created by 이승준 on 12/23/25.
//

import Combine

protocol ViewModelProtocol {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
}

class CalculatorViewModel: ViewModelProtocol {
    
    struct Input {
        let tapNumber = PassthroughSubject<Double, Never>()
        let tapOperator = PassthroughSubject<CalcOperator, Never>()
        let tapEqual = PassthroughSubject<Void, Never>()
        let tapClear = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        let displayText = CurrentValueSubject<String, Never>("0")
    }
    
    private let service: CalculatorServiceType // DI 적용
    private var cancellables = Set<AnyCancellable>()
    
    private var lhs: Double?
    private var currentOperator: CalcOperator?
    private var rhs: Double?
    
    init(service: CalculatorServiceType = CalculatorService()) {
        self.service = service
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.tapNumber
            .sink { [weak self] number in
                guard let self = self else { return }
                if self.currentOperator == nil {
                    self.lhs = number
                } else {
                    self.rhs = number
                }
                output.displayText.send("\(number)")
            }
            .store(in: &cancellables)
        
        input.tapOperator
            .sink { [weak self] op in
                self?.currentOperator = op
            }
            .store(in: &cancellables)
        
        input.tapEqual
            .sink { [weak self] in
                guard let self = self,
                      let lhs = self.lhs,
                      let rhs = self.rhs,
                      let op = self.currentOperator else { return }
                
                let result = self.service.calculate(lhs: lhs, rhs: rhs, operator: op)
                let resultString = result.isNaN ? "Error" : "\(result)"
                output.displayText.send(resultString)
                
                // 다음 연산을 위해 상태 업데이트
                self.lhs = result
                self.rhs = nil
                self.currentOperator = nil
            }
            .store(in: &cancellables)
        
        // AC
        input.tapClear
            .sink { [weak self] in
                self?.lhs = nil
                self?.rhs = nil
                self?.currentOperator = nil
                output.displayText.send("0")
            }
            .store(in: &cancellables)
        
        return output
    }
}
