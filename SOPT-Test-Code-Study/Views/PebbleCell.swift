//
//  PebbleCell.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit
import SnapKit
import Then

final class PebbleCell: UICollectionViewCell {
    
    private lazy var title = UILabel().then {
        $0.font = UIFont(name: Pretendard.Regular.name(), size: 14)
    }
    
    private lazy var imageView = UIImageView().then {
        $0.backgroundColor = .baeminBackgroundWhite
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 20
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    func configure(_ data: MarketData) {
        title.text = data.name
        imageView.image = data.image
    }
    
    func configure(_ data: CategoryCellData) {
        title.text = data.name
        imageView.image = data.image
    }
    
    func setUI() {
        self.addSubview(title)
        self.addSubview(imageView)
        
        self.snp.makeConstraints { make in
            make.width.equalTo(62)
            make.height.equalTo(78)
        }
        
        title.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.size.equalTo(58)
        }
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

