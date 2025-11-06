//
//  UIFont+.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/23/25.
//

import UIKit

public extension UIFont {
    enum FontType: String {
        case bold = "Pretendard-Bold"
        case extrabold = "Pretendard-ExtraBold"
        case extralight = "Pretendard-ExtraLight"
        case light = "Pretendard-Light"
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semibold = "Pretendard-Semibold"
        case thin = "Pretendard-Thin"
        
        var name: String {
            return self.rawValue
        }
        
        static func font(_ type: FontType, ofsize size: CGFloat) -> UIFont {
            if let font = UIFont(name: type.rawValue, size: size) {
                return font
            }
            else {
                fatalError("font not found")
            }
        }
    }
}
