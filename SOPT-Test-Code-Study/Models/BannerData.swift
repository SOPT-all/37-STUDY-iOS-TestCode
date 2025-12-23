//
//  BannerData.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit

struct BannerData {
    var image: UIImage
    
    static let data: [BannerData] = [
        BannerData(image: .banner01),
        BannerData(image: .banner02),
        BannerData(image: .banner03),
    ]
}
