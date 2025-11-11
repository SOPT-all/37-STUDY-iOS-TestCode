//
//  RankCell.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit
import SnapKit
import Then

final class RankCell: UICollectionViewCell {
    
    private lazy var mainImageView = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.backgroundColor = .baeminGray200
    }
    
    private lazy var restaurantNameLabel = commonLabel()
    
    private lazy var starImageView = UIImageView().then {
        $0.image = .reviewStar
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var reviewAverageScoreLabel = commonLabel()
    private lazy var reviewCountLabel = commonLabel()
    
    private lazy var menuNameLabel = UILabel().then {
        $0.text = "메뉴 이름"
        $0.textColor = .baeminBlack
        $0.font = UIFont(name: Pretendard.Regular.name(), size: 14)
    }
    private lazy var discountPercentLabel = UILabel().then {
        $0.text = "25%"
        $0.textColor = .baeminRed
        $0.font = UIFont(name: Pretendard.Bold.name(), size: 14)
    }
    private lazy var discountPriceLabel = UILabel().then {
        $0.text = "12,000원"
        $0.textColor = .baeminBlack
        $0.font = UIFont(name: Pretendard.Bold.name(), size: 14)
    }
    private lazy var originalPriceLabel = UILabel().then {
        $0.text = "16,000원"
        $0.textColor = UIColor.gray.withAlphaComponent(0.5)
        $0.font = UIFont(name: Pretendard.Regular.name(), size: 12)
    }
    private lazy var noMinimumLabel = UILabel().then {
        $0.text = "최소주문금액 없음"
        $0.textColor = .baeminBlue700
        $0.font = UIFont(name: Pretendard.Bold.name(), size: 13)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setUI()
    }
    
    func configure(_ data: RankData) {
        mainImageView.image = data.menuImage
        restaurantNameLabel.text = data.restaurantName
        reviewAverageScoreLabel.text = "\(data.reviewAverageScore)"
        reviewCountLabel.text = "(\(data.reviewCount))"
        menuNameLabel.text = data.menuName
        discountPercentLabel.text = "\(data.discountPercent)%"
        discountPriceLabel.text = "\(data.discountPrice)원"
        originalPriceLabel.text = "\(data.originalPrice)원"
    }
    
    func addSubviews() {
        [mainImageView,
         restaurantNameLabel,starImageView, reviewAverageScoreLabel,reviewCountLabel,
         menuNameLabel,
         discountPercentLabel, discountPriceLabel,
         originalPriceLabel,noMinimumLabel].forEach{
            self.addSubview($0)
        }
    }
    
    func setUI() {
        mainImageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.size.equalTo(145)
        }
        reviewCountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(mainImageView.snp.bottom).offset(9)
            make.height.equalTo(12)
            make.width.lessThanOrEqualTo(35)
        }
        reviewAverageScoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(reviewCountLabel)
            make.trailing.equalTo(reviewCountLabel.snp.leading)
            make.height.equalTo(12)
            make.width.equalTo(17)
        }
        starImageView.snp.makeConstraints { make in
            make.centerY.equalTo(reviewCountLabel)
            make.trailing.equalTo(reviewAverageScoreLabel.snp.leading)
            make.size.equalTo(12)
        }
        restaurantNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(reviewCountLabel)
            make.leading.equalToSuperview()
            make.trailing.equalTo(starImageView.snp.leading).priority(.medium)
            make.height.equalTo(12)
        }
        menuNameLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewCountLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        discountPercentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(menuNameLabel.snp.bottom).offset(6)
        }
        discountPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(discountPercentLabel.snp.trailing).offset(6)
            make.centerY.equalTo(discountPercentLabel)
        }
        originalPriceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(discountPriceLabel.snp.bottom).offset(6)
        }
        noMinimumLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(originalPriceLabel.snp.bottom).offset(6)
        }
    }
    
    func commonLabel() -> UILabel {
        return UILabel().then {
            $0.font = UIFont(name: Pretendard.Regular.name(), size: 12)
            $0.textColor = UIColor.baeminGray600
            $0.numberOfLines = 0
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
