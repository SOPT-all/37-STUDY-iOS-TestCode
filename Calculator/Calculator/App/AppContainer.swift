//
//  AppContainer.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


struct AppContainer {
    let engine: CalculatorEngine

    init(engine: CalculatorEngine = DefaultCalculatorEngine()) {
        self.engine = engine
    }

    func makeCalculatorViewModel() -> CalculatorViewModel {
        CalculatorViewModel(engine: engine)
    }
}