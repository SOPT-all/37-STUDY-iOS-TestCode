//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by 김호성 on 2025.12.26.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
    
    private var sut: CalculatorViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = CalculatorViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        sut = nil
    }

    func test_십일더하기육() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        sut.buttonTapped(.one)
        sut.buttonTapped(.one)
        sut.buttonTapped(.add)
        sut.buttonTapped(.six)
        sut.buttonTapped(.equal)
        
        XCTAssertEqual(sut.stack.map(\.text).joined(separator: " "), "17")
    }
    
    func test_십일더하기육빼기() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        sut.buttonTapped(.one)
        sut.buttonTapped(.one)
        sut.buttonTapped(.add)
        sut.buttonTapped(.six)
        sut.buttonTapped(.equal)
        sut.buttonTapped(.subtract)
        
        XCTAssertEqual(sut.stack.map(\.text).joined(separator: " "), "17 -")
    }
    
    func test_십일더하기육빼기빼기() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        sut.buttonTapped(.one)
        sut.buttonTapped(.one)
        sut.buttonTapped(.add)
        sut.buttonTapped(.six)
        sut.buttonTapped(.equal)
        sut.buttonTapped(.subtract)
        sut.buttonTapped(.subtract)
        
        XCTAssertEqual(sut.stack.map(\.text).joined(separator: " "), "17 -")
    }
    
    func test_클리어() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        sut.buttonTapped(.one)
        sut.buttonTapped(.one)
        sut.buttonTapped(.add)
        sut.buttonTapped(.six)
        sut.buttonTapped(.equal)
        sut.buttonTapped(.subtract)
        sut.buttonTapped(.subtract)
        sut.buttonTapped(.clear)
        
        XCTAssertEqual(sut.stack.map(\.text).joined(separator: " "), "")
    }
    
    func test_사십오이레이즈() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        sut.buttonTapped(.four)
        sut.buttonTapped(.five)
        sut.buttonTapped(.erase)
        
        XCTAssertEqual(sut.stack.map(\.text).joined(separator: " "), "4")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
