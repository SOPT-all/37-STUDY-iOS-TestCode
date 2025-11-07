//
//  UITextField+.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.22.
//

import Foundation
import UIKit

extension UITextField {
    func addLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func addRightPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
