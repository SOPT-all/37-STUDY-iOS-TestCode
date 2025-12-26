//
//  DisplayView.swift
//  CalculatorProject
//
//  Created by JIN on 12/26/25.
//

import SwiftUI

struct DisplayView: View {
    let text: String

    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .font(.system(size: 64, weight: .light))
                .foregroundColor(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .frame(height: 100)
    }
}
