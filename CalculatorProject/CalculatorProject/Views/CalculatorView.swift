//
//  CalculatorView.swift
//  CalculatorProject
//
//  Created by JIN on 12/26/25.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject private var viewModel = AppDIContainer.shared.makeCalculatorViewModel()

    private let buttonRows: [[CalculatorButton]] = [
        [.clear, .add, .subtract, .multiply],
        [.seven, .eight, .nine, .divide],
        [.four, .five, .six, .equal],
        [.one, .two, .three, .zero]
    ]
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(spacing: 12) {
                DisplayView(text: viewModel.displayValue)
                    .padding(.top, 30)
                Spacer()
                ForEach(buttonRows, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button) {
                                viewModel.buttonPressed(button)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CalculatorView()
}
