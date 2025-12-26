//
//  AppDIContainer.swift
//  CalculatorProject
//
//  Created by JIN on 12/26/25.
//

import Foundation

final class AppDIContainer {
    static let shared = AppDIContainer()

    private init() {}

    func makeCalculatorViewModel() -> CalculatorViewModel {
        let calculator = Calculator()
        return CalculatorViewModel(calculator: calculator)
    }
}
