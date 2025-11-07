//
//  UIStackView+.swift
//  Baemin
//
//  Created by 진소은 on 10/31/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
