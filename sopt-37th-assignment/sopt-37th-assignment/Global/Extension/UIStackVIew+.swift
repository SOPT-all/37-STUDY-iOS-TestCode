//
//  UIStackVIew+.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/24/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
