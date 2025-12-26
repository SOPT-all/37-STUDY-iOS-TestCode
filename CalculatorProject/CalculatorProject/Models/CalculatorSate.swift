//
//  CalculatorSate.swift
//  CalculatorProject
//
//  Created by JIN on 12/25/25.
//

import SwiftUI

struct CalculatorState {
    var currentValue: Double = 0
    var storedValue: Double?
    var currentOperation: Operation?
    var isNewInput: Bool = true
    
    mutating func reset() {
        currentValue = 0
        storedValue = nil
        currentOperation = nil
        isNewInput = true
    }
}
