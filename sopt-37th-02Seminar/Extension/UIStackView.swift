//
//  UIStackView.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/27/25.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
