//
//  UIView+.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/29/25.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
