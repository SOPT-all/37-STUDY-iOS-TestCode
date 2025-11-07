//
//  UIView+.swift
//  AhnChiWook_assignment
//
//  Created by 안치욱 on 10/26/25.
//


import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}