//
//  Fonts.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/27/25.
//

import Foundation

enum Pretendard: String {
    case Regular, Pretendard, ExtraLight, Light, Medium, SemiBold, Bold, ExtraBold, Black
    
    func name() -> String {
        return "Pretendard-" + self.rawValue
    }
}
