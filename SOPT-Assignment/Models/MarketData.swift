//
//  MarketData.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit

struct MarketData {
    var name: String
    var image: UIImage
    
    static let data: [MarketData] = [
        MarketData(name: "B마트", image: .baeminMart),
        MarketData(name: "CU", image: .cu),
        MarketData(name: "이마트슈퍼", image: .emart),
        MarketData(name: "홈플러스", image: .homeplus),
        MarketData(name: "GS25", image: .gs25),
        MarketData(name: "홈플슈퍼", image: .homeplusSuper),
        MarketData(name: "이마트24", image: .emart24),
        MarketData(name: "GS더프레시", image: .gsTheFresh),
        MarketData(name: "JAJU", image: .jaju),
        MarketData(name: "펫마트", image: .petMart),
        ]
}

