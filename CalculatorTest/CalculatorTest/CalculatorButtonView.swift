//
//  CalculatorButtonView.swift
//  CalculatorTest
//
//  Created by 김나연 on 12/26/25.
//

import SwiftUI

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
