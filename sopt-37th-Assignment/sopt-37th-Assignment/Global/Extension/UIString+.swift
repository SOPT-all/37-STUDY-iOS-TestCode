//
//  UIString+.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/31/25.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let regularExpression = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regularExpression = "^[A-Za-z0-9!_@$%^&+=]{4,12}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
}
