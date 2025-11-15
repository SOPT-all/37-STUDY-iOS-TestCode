//
//  UITextField.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/27/25.
//

import Foundation
import UIKit

enum TextFieldStyle: Int {
    case email 
    case password
}

extension UITextField {
    
    func placeholderFallback() {
        
        switch TextFieldStyle(rawValue: self.tag) {
        case .email:
            self.placeholder = "이메일 아이디"
        case .password:
            self.placeholder = "비밀번호"
        default:
            break
        }
     
    }
    
    func addHorizontalPadding() {
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15,height: self.frame.height))
        self.leftView = leftPadding
        self.leftViewMode = ViewMode.always
        
        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15,height: self.frame.height))
        self.rightView = rightPadding
        self.rightViewMode = ViewMode.always
        
    }
    
    
}
