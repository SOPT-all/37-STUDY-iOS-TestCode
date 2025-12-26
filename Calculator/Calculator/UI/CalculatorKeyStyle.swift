//
//  CalculatorKeyStyle.swift
//  Calculator
//
//  Created by 안치욱 on 12/26/25.
//


import SwiftUI

struct CalculatorKeyStyle: ButtonStyle {
    let isOperator: Bool
    let isFunction: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 28, weight: .semibold))
            .frame(maxWidth: .infinity, minHeight: 56)
            .foregroundStyle(.white)
            .background(backgroundColor(configuration.isPressed))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }

    private func backgroundColor(_ pressed: Bool) -> Color {
        if isOperator { return pressed ? .orange.opacity(0.85) : .orange }
        if isFunction { return pressed ? .gray.opacity(0.85) : .gray }
        return pressed ? .gray.opacity(0.7) : .gray.opacity(0.55)
    }
}