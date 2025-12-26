//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


import SwiftUI

import Combine


@MainActor
final class CalculatorViewModel: ObservableObject {
    @Published private(set) var state: CalculatorState

    private let engine: CalculatorEngine

    init(engine: CalculatorEngine, initial: CalculatorState = .init()) {
        self.engine = engine
        self.state = initial
    }

    func send(_ action: CalculatorAction) {
        state = engine.reduce(state: state, action: action)
    }
}
