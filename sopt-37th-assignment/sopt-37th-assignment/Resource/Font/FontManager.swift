//
//  FontManager.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/23/25.
//

import UIKit

public struct FontProperty {
    let font: UIFont.FontType
    let size: CGFloat
    let lineHeight: CGFloat
    let kern: CGFloat
}

public enum FontManager {
    case headB24
    case headB18
    
    case titleSb18
    
    case bodyR14
    
    case captionR10
    
    public var fontProperty: FontProperty {
        switch self {
        case .headB24:
            return FontProperty(font: .bold, size: 24, lineHeight: 100, kern: -2)
        case .headB18:
            return FontProperty(font: .bold, size: 18, lineHeight: 100, kern: -2)
        case .titleSb18:
            return FontProperty(font: .semibold, size: 18, lineHeight: 100, kern: -3)
        case .bodyR14:
            return FontProperty(font: .regular, size: 14, lineHeight: 100, kern: -4)
        case .captionR10:
            return FontProperty(font: .regular, size: 10, lineHeight: 199, kern: -4)
        }
    }
}

public extension FontManager {
    var font: UIFont {
        guard let font = UIFont(name: fontProperty.font.name, size: fontProperty.size) else {
            return UIFont()
        }
        return font
    }
}

