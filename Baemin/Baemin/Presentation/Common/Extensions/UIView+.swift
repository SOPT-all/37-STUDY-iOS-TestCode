//
//  UIView+.swift
//  Baemin
//
//  Created by 진소은 on 10/26/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
