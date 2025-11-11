//
//  BannerCell.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit
import SnapKit
import Then

final class BannerCell: UICollectionViewCell {
    
    private lazy var bannerImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bannerImage)
        bannerImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ data: BannerData) {
        self.bannerImage.image = data.image
    }
}

