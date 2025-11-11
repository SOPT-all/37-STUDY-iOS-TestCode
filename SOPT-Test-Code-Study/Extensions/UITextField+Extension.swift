//
//  UITextField+Extension.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/27/25.
//

import UIKit

extension UITextField {
    func addLeftPadding(_ width: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(_ width: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
        /// 텍스트 필드에 좌우 패딩을 한 번에 추가합니다.
    func addPadding(leftAmount: CGFloat = 10, rightAmount: CGFloat = 10) {
        addLeftPadding(leftAmount)
        addRightPadding(rightAmount)
    }
    
    func setEdittingMode() {
        self.layer.borderColor = UIColor.baeminBlack.cgColor
        self.layer.borderWidth = 2
    }
    
    func setEdittingEndMode() {
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }
}
