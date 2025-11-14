//
//  Font+Extension.swift
//  spot-37th-assignment
//
//  Created by 어재선 on 10/30/25.
//

import Foundation
import UIKit

enum PretendardWeight: String {
    case black = "Pretendard-Black"
    case bold = "Pretendard-Bold"
    case extraBold = "Pretendard-ExtraBold"
    case extraLight = "Pretendard-ExtraLight"
    case light = "Pretendard-Light"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
    case semiBold = "Pretendard-SemiBold"
    case thin = "Pretendard-Thin"
}

extension UIFont {
    
    static let head_b_24: UIFont = UIFont(name: PretendardWeight.bold.rawValue, size: 24) ?? UIFont()
    static let head_b_18: UIFont = UIFont(name: PretendardWeight.bold.rawValue, size: 18) ?? UIFont()
    static let title_sb_18: UIFont = UIFont(name: PretendardWeight.semiBold.rawValue, size: 18) ?? UIFont()
    static let body_r_14: UIFont = UIFont(name: PretendardWeight.regular.rawValue, size: 14) ?? UIFont()
    static let caption_r_10: UIFont = UIFont(name: PretendardWeight.regular.rawValue, size: 10) ?? UIFont()
    
}
