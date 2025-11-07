//
//  UIFont+.swift
//  AhnChiWook_assignment
//
//  Created by 안치욱 on 10/26/25.
//


import UIKit

extension UIFont {
    enum FontFamily {
        case thin, extraLight, light, regular, medium, semiBold, bold, extraBold, black
        
        var kind: String {
            switch self {
            case .thin:
                return "Thin"
            case .extraLight:
                return "ExtraLight"
            case .light:
                return "Light"
            case .regular:
                return "Regular"
            case .medium:
                return "Medium"
            case .semiBold:
                return "SemiBold"
            case .bold:
                return "Bold"
            case .extraBold:
                return "ExtraBold"
            case .black:
                return "Black"
            }
        }
    }
    
    static func pretendard(_ fontFamily: FontFamily, size: CGFloat) -> UIFont {
        guard let pretendardFont = UIFont(name: "Pretendard-\(fontFamily.kind)", size: size) else {
            print("😂Pretendard-\(fontFamily.kind)가 없어요")
            return UIFont.systemFont(ofSize: size)
        }
        
        return pretendardFont
    }
    
    static let head_b_24 = UIFont.pretendard(.bold, size: 24)
    static let head_b_18 = UIFont.pretendard(.bold, size: 18)
    static let title_sb_18 = UIFont.pretendard(.semiBold, size: 18)
    static let body_r_14 = UIFont.pretendard(.regular, size: 14)
    static let caption_r_10 = UIFont.pretendard(.regular, size: 10)
}
