//
//  CalculatorView.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


import SwiftUI

struct CalculatorView: View {
    @StateObject var viewModel: CalculatorViewModel

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)

    private let keys: [[CalcButton]] = [
        [.clear, .toggleSign, .percent, .delete],
        [.digit(7), .digit(8), .digit(9), .op(.div)],
        [.digit(4), .digit(5), .digit(6), .op(.mul)],
        [.digit(1), .digit(2), .digit(3), .op(.sub)],
        [.digit(0), .dot, .equals, .op(.add)]
    ]

    var body: some View {
        VStack(spacing: 16) {
            displayArea

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(keys.flatMap { $0 }, id: \.a11yId) { key in
                    Button {
                        viewModel.send(key.toAction())
                    } label: {
                        Text(key.title)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(CalculatorKeyStyle(
                        isOperator: isOperator(key),
                        isFunction: isFunction(key)
                    ))
                    .accessibilityIdentifier(key.a11yId)
                }
            }
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }

    private var displayArea: some View {
        VStack(alignment: .trailing, spacing: 6) {
            if let err = viewModel.state.error {
                Text(err)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }

            Text(viewModel.state.display)
                .font(.system(size: 52, weight: .semibold))
                .foregroundStyle(.white)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .accessibilityIdentifier("display")
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 6)
    }

    private func isOperator(_ k: CalcButton) -> Bool {
        if case .op = k { return true }
        if case .equals = k { return true }
        return false
    }

    private func isFunction(_ k: CalcButton) -> Bool {
        switch k {
        case .clear, .toggleSign, .percent, .delete: return true
        default: return false
        }
    }
}