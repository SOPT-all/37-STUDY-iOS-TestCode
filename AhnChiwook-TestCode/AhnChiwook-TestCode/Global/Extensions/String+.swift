//
//  String+.swift
//  AhnChiWook_assignment
//
//  Created by 안치욱 on 10/26/25.
//

import Foundation

extension String {
    
    /// email 정규식 조건에 맞는지 확인하는 함수입니다
    var isValidEmail: Bool {
        let regularExpression = "^[A-Z0-9a-z._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
    
    /// 비밀번호 정규식 조건에 맞는지 확인하는 함수입니다
    var isValidPassword: Bool {
        let regularExpression = "^(?=.*[!_@$%^&+=])[A-Za-z0-9!_@$%^&+=]{8,15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
}
