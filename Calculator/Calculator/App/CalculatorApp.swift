//
//  CalculatorApp.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


import SwiftUI

@main
struct CalculatorApp: App {
    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            CalculatorView(viewModel: container.makeCalculatorViewModel())
        }
    }
}
