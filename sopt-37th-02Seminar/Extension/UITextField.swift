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
    
//placeholder를 간편하게 호출하기위한 시도..
// 어차피 MainViewController에서 조건문을 사용해야 했기 때문에 이게 굳이 필요했는지 의문이었어서 주석으로 변경했습니다

//    func changePlaceholder() {
//        
//        switch TextFieldStyle(rawValue: self.tag) {
//        case .email:
//            self.placeholder = "이메일 또는 아이디를 입력해주세요"
//        case .password:
//            self.placeholder = "비밀번호를 입력해주세요"
//        default:
//            break
//        }
//        
//    }
    
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
