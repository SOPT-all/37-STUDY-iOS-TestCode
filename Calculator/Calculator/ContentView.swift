//
//  ContentView.swift
//  Calculator
//
//  Created by 김호성 on 2025.12.26.
//

import SwiftUI

struct ContentView: View {
    
    let buttons: [CalculatorButtonType] = [
        .erase, .clear, .modular, .divide,
        .seven, .eight, .nine, .multiply,
        .four, .five, .six, .subtract,
        .one, .two, .three, .add,
        .sign, .zero, .decimal, .equal,
    ]
    
    @StateObject var calculatorViewModel: CalculatorViewModel = .init()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(calculatorViewModel.stack.map(\.text).joined(separator: " "))
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                ForEach(buttons, id: \.self) { type in
                    CalculatorButton(action: {
                        print(type.title)
                        calculatorViewModel.buttonTapped(type)
                    }, type: type)
                    .aspectRatio(1, contentMode: .fill)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
