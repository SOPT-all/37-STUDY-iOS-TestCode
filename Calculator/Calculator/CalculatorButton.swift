//
//  CalculatorButton.swift
//  Calculator
//
//  Created by 김호성 on 2025.12.26.
//

import SwiftUI

struct CalculatorButton: View {
    
    let action: () -> Void
    let type: CalculatorButtonType
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                Circle()
                    .fill(type.backgroundColor)
                
                Text(type.title)
            }
        })
        .foregroundStyle(.white)
    }
}

#Preview {
    CalculatorButton(action: {
        print("action")
    }, type: .add)
}
