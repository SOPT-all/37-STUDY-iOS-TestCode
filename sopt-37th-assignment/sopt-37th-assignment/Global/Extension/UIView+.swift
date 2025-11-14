//
//  UIView+.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/23/25.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
