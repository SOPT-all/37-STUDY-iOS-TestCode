//
//  CalculatorViewModel.swift
//  SOPT-Test-Code-Study
//
//  Created by 이승준 on 12/23/25.
//

import Combine

class CalculatorViewModel {
    struct Input {
        let tapNumber = PassthroughSubject<Double, Never>()
        let tapOperator = PassthroughSubject<CalcOperator, Never>()
        let tapEqual = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        let displayText = CurrentValueSubject<String, Never>("0")
    }
    
    private let service: CalculatorServiceType // DI 적용
    private var cancellables = Set<AnyCancellable>()
    
    init(service: CalculatorServiceType = CalculatorService()) {
        self.service = service
        // Input을 받아 로직 처리 후 Output으로 전달하는 바인딩 구현
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        // Combine 연산자(combineLatest 등)를 활용한 로직
        return output
    }
}
