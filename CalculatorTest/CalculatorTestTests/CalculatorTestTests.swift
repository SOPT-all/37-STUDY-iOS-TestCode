//
//  CalculatorTestTests.swift
//  CalculatorTestTests
//
//  Created by 김나연 on 12/26/25.
//

import XCTest
@testable import CalculatorTest

final class CalculatorTestTests: XCTestCase {

    var sut: CalculatorModel!
    
    override func setUp() {
        super.setUp()
        sut = CalculatorModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    
    // MARK: - Addition Tests
    
    func test_performOperation_AddTwoNumbers_ReturnsSum() {
        // Given: 5 + 3을 입력
        sut.inputNumber("5")
        sut.inputOperation(.add)
        sut.inputNumber("3")
        
        // When: = 버튼을 누름
        sut.performOperation()
        
        // Then: 결과는 8
        XCTAssertEqual(sut.displayValue, "8")
    }
    
    
    // MARK: - Subtraction Tests
    
    func test_performOperation_SubtractTwoNumbers_ReturnsDifference() {
        // Given: 10 - 3을 입력
        sut.inputNumber("1")
        sut.inputNumber("0")
        sut.inputOperation(.subtract)
        sut.inputNumber("3")
        
        // When: = 버튼을 누름
        sut.performOperation()
        
        // Then: 결과는 7
        XCTAssertEqual(sut.displayValue, "7")
    }
    
    
    // MARK: - Multiplication Tests
    
    func test_performOperation_MultiplyTwoNumbers_ReturnsProduct() {
        // Given: 4 × 5를 입력
        sut.inputNumber("4")
        sut.inputOperation(.multiply)
        sut.inputNumber("5")
        
        // When: = 버튼을 누름
        sut.performOperation()
        
        // Then: 결과는 20
        XCTAssertEqual(sut.displayValue, "20")
    }
    
    
    // MARK: - Division Tests
    
    func test_performOperation_DivideTwoNumbers_ReturnsQuotient() {
        // Given: 15 ÷ 3을 입력
        sut.inputNumber("1")
        sut.inputNumber("5")
        sut.inputOperation(.divide)
        sut.inputNumber("3")
        
        // When: = 버튼을 누름
        sut.performOperation()
        
        // Then: 결과는 5
        XCTAssertEqual(sut.displayValue, "5")
    }
}
