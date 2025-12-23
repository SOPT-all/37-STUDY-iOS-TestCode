//
//  CalculatorViewModelTests.swift
//  SOPT-Test-Code-StudyTests
//
//  Created by 이승준 on 12/23/25.
//

import XCTest
import Combine
@testable import SOPT_Test_Code_Study

final class CalculatorViewModelTests: XCTestCase {
    
    private var sut: CalculatorViewModel!
    private var input: CalculatorViewModel.Input!
    private var output: CalculatorViewModel.Output!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        sut = CalculatorViewModel()
        input = CalculatorViewModel.Input()
        output = sut.transform(input: input)
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        input = nil
        output = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_initialState_showsZero() {
        XCTAssertEqual(output.displayText.value, "0", "초기 화면은 0이어야 합니다.")
    }
    
    func test_tapNumber_updatesDisplayText() {
        // given
        let numberToTap = 5.0
        
        // when
        input.tapNumber.send(numberToTap)
        
        // then
        XCTAssertEqual(output.displayText.value, "5.0", "숫자를 누르면 해당 숫자가 화면에 표시되어야 합니다.")
    }
    
    func test_addition_showsCorrectResult() {
        // given
        var receivedValues: [String] = []
        output.displayText
            .sink { receivedValues.append($0) }
            .store(in: &cancellables)
        
        // when
        input.tapNumber.send(1.0)
        input.tapOperator.send(.add)
        input.tapNumber.send(2.0)
        input.tapEqual.send(())
        
        // then
        XCTAssertEqual(receivedValues.last, "3.0", "1 + 2의 결과는 3이어야 합니다.")
    }

    func test_divideByZero_showsError() {
        // given
        input.tapNumber.send(10.0)
        input.tapOperator.send(.divide)
        input.tapNumber.send(0.0)
        
        // when
        input.tapEqual.send(())
        
        // then
        XCTAssertEqual(output.displayText.value, "Error", "0으로 나누면 Error 메시지가 표시되어야 합니다.")
    }
    
    func test_tapClear_resetsDisplayText() {
        // given
        input.tapNumber.send(9.0)
        input.tapOperator.send(.multiply)
        
        // when
        input.tapClear.send(())
        
        // then
        XCTAssertEqual(output.displayText.value, "0", "AC를 누르면 화면이 0으로 초기화되어야 합니다.")
    }
}
