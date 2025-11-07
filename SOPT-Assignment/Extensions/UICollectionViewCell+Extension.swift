//
//  UICollectionView+Extension.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit

extension UICollectionViewCell {
    static func identifier() -> String {
        return String(describing: type(of: self))
    }
}
