//
//  PaddingLabel.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.25.
//

import Foundation
import UIKit

final class PaddingLabel: UILabel {
    
    var padding: UIEdgeInsets?
    
    override func drawText(in rect: CGRect) {
        guard let padding else {
            super.drawText(in: rect)
            return
        }
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        guard let padding else {
            return size
        }
        let width = size.width + padding.left + padding.right
        let height = size.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
    
    override var bounds: CGRect {
        didSet {
            guard let padding else { return }
            preferredMaxLayoutWidth = bounds.width - (padding.left + padding.right)
        }
    }
}
