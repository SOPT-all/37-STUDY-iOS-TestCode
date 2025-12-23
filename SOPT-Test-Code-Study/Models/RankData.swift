//
//  RankData.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit

struct RankData {
    var menuImage: UIImage
    var menuName: String
    var restaurantName: String
    var discountPercent: Float
    var reviewAverageScore: Float
    var reviewCount: Int
    var originalPrice: Int
    var discountPrice: Int
    
    static let data: [RankData] = [
        RankData(menuImage: UIImage(), menuName: "[든든한 한끼]보쌈 막국수", restaurantName: "백억보쌈제육덮밥", discountPercent: 25.0, reviewAverageScore: 5.0, reviewCount: 1973, originalPrice: 16000, discountPrice: 12000),
        RankData(menuImage: UIImage(), menuName: "(1인)피자 + 사이드 set", restaurantName: "파파존스", discountPercent: 25.0, reviewAverageScore: 5.0, reviewCount: 1973, originalPrice: 16000, discountPrice: 12000),
        RankData(menuImage: UIImage(), menuName: "막국수", restaurantName: "족발", discountPercent: 25.0, reviewAverageScore: 5.0, reviewCount: 1973, originalPrice: 16000, discountPrice: 12000),
    ]
}

