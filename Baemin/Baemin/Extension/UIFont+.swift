//
//  UIFont+.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.21.
//

import Foundation
import UIKit

enum PretendardWeight: String {
    case black      = "Black"
    case extraBold  = "ExtraBold"
    case bold       = "Bold"
    case semiBold   = "SemiBold"
    case medium     = "Medium"
    case regular    = "Regular"
    case light      = "Light"
    case extraLight = "ExtraLight"
    case thin       = "Thin"
    
    var name: String {
        return "Pretendard-\(rawValue)"
    }
}

enum PretendardStyle {
    case head_b_24
    case head_b_18
    case title_sb_18
    case body_r_14
    case caption_r_10
    
    private var weight: PretendardWeight {
        switch self {
        case .head_b_24:
            return .bold
        case .head_b_18:
            return .bold
        case .title_sb_18:
            return .semiBold
        case .body_r_14:
            return .regular
        case .caption_r_10:
            return .regular
        }
    }
    var name: String {
        return weight.name
    }
    var size: CGFloat {
        switch self {
        case .head_b_24:
            return 24
        case .head_b_18:
            return 18
        case .title_sb_18:
            return 18
        case .body_r_14:
            return 14
        case .caption_r_10:
            return 10
        }
    }
}

extension UIFont {
    static func pretendard(_ weight: PretendardWeight = .regular, size fontSize: CGFloat) -> UIFont? {
        return UIFont(name: weight.name, size: fontSize)
    }
    
    static func pretendard(_ style: PretendardStyle) -> UIFont? {
        return UIFont(name: style.name, size: style.size)
    }
}
