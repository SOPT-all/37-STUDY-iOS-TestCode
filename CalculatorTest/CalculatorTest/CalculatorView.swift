//
//  CalculatorView.swift
//  CalculatorTest
//
//  Created by 김나연 on 12/26/25.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .toggleSign, .percentage, .operation(.divide)],
        [.digit(7), .digit(8), .digit(9), .operation(.multiply)],
        [.digit(4), .digit(5), .digit(6), .operation(.subtract)],
        [.digit(1), .digit(2), .digit(3), .operation(.add)],
        [.digit(0), .decimal, .equals]
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 12) {
                Spacer()
                
                // 디스플레이
                displayView
                
                // 버튼 그리드
                buttonGrid
            }
            .padding()
        }
    }
    
    // MARK: - Display View
    private var displayView: some View {
        HStack {
            Spacer()
            Text(viewModel.displayText)
                .font(.system(size: 80, weight: .light))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.bottom, 20)
    }
    
    // MARK: - Button Grid
    private var buttonGrid: some View {
        VStack(spacing: 12) {
            ForEach(buttons.indices, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(buttons[row], id: \.title) { button in
                        CalculatorButtonView(button: button) {
                            viewModel.buttonTapped(button)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Calculator Button View
struct CalculatorButtonView: View {
    let button: CalculatorButton
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(button.title)
                .font(.system(size: 32, weight: .medium))
                .foregroundColor(buttonForegroundColor)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(buttonBackgroundColor)
                .cornerRadius(buttonWidth / 2)
        }
    }
    
    private var buttonWidth: CGFloat {
        // 0 버튼은 2배 너비
        if case .digit(0) = button {
            return (UIScreen.main.bounds.width - 5 * 12) / 4 * 2 + 12
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    private var buttonHeight: CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    private var buttonBackgroundColor: Color {
        switch button.backgroundColor {
        case "orange":
            return Color.orange
        case "lightGray":
            return Color(white: 0.8)
        case "darkGray":
            return Color(white: 0.3)
        default:
            return Color.gray
        }
    }
    
    private var buttonForegroundColor: Color {
        button.backgroundColor == "lightGray" ? .black : .white
    }
}
