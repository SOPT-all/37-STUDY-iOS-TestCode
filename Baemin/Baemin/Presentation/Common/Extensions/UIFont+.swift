//
//  UIFont+.swift
//  Baemin
//
//  Created by 진소은 on 10/26/25.
//

import UIKit

extension UIFont {
    
    enum Family: String, CaseIterable {
        case Black, Bold, ExtraBold, ExtraLight, Light, Medium, Regular, Semibold, Thin
    }
    
    enum SuitStyle {
        case head_b_24
        case head_b_18
        case title_sb_18
        case body_r_14
        case caption_r_10
    }
    
    static func pretendard(weight: Family = .Regular, size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Pretendard-\(weight.rawValue)", size: size) {
            return font
        } else {
            print("Pretendard-\(weight.rawValue) loading failed, fallback to system font")
            return .systemFont(ofSize: size)
        }
    }
    
    static func pretendard(_ style: SuitStyle) -> UIFont {
        switch style {
        case .head_b_24: return .pretendard(weight: .Bold, size: 24)
        case .head_b_18: return .pretendard(weight: .Bold, size: 18)
        case .title_sb_18: return .pretendard(weight: .Semibold, size: 18)
        case .body_r_14: return .pretendard(weight: .Regular, size: 14)
        case .caption_r_10: return .pretendard(weight: .Regular, size: 10)
        }
    }
}
