//
//  String+.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/25/25.
//

import Foundation

extension String {
    var isValidEmail: Bool {
       let regularExpression = "^[A-Z0-9a-z._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$"
       let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
       return predicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regularExpression = "^(?=.*[!_@$%^&+=])[A-Za-z0-9!_@$%^&+=]{8,12}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
}
