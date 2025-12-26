//
//  CalculatorUITests.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//

import XCTest

@testable import Calculator

final class CalculatorUITests: XCTestCase {

    func test_1_plus_2_equals_3() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["btn_1"].tap()
        app.buttons["btn_add"].tap()
        app.buttons["btn_2"].tap()
        app.buttons["btn_equals"].tap()

        XCTAssertEqual(app.staticTexts["display"].label, "3")
    }

    func test_divideByZero_showsError() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["btn_8"].tap()
        app.buttons["btn_div"].tap()
        app.buttons["btn_0"].tap()
        app.buttons["btn_equals"].tap()

        XCTAssertEqual(app.staticTexts["display"].label, "Error")
    }
}
