//
//  CalculatorButtonView.swift
//  CalculatorProject
//
//  Created by JIN on 12/26/25.
//

import SwiftUI

struct CalculatorButtonView: View {
    let button: CalculatorButton
    let action: () -> Void

    private var backgroundColor: Color {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal, .clear:
            return Color.blue
        default:
            return Color.gray
        }
    }

    private var foregroundColor: Color {
        return .white
    }

    var body: some View {
        Button(action: action) {
            Text(button.title)
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(foregroundColor)
                .frame(width: 80, height: 80)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}

