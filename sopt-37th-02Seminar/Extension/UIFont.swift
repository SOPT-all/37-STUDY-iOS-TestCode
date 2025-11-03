//
//  UIFont.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/26/25.
//

import Foundation
import UIKit

enum FontName: String {
    case pretendardBold = "Pretendard-Bold"
    case pretendardSemiBold = "Pretendard-SemiBold"
    case pretendardLight = "Pretendard-Light"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
    case pretendardExtraBold = "Pretendard-ExtraBold"
}
 
extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: style.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
    
    
    @nonobjc class var size17: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 17)
    }
    
    @nonobjc class var size24: UIFont {
        return UIFont.font(.pretendardExtraBold, ofSize: 24)
    }
}
