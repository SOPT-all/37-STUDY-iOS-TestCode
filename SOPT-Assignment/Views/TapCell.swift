//
//  TapCell.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/6/25.
//

import UIKit
import SnapKit
import Then

final class TapCell: UICollectionViewCell {
    
    private lazy var label = UILabel().then {
        $0.font = UIFont(name: Pretendard.Bold.name(), size: 18)
        $0.textColor = .baeminGray300
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(20)
        }
    }
    
    func selected() {
        label.textColor = .black
    }
    
    func deselected() {
        label.textColor = .baeminGray300
    }
    
    func configure(_ title: String) {
        label.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
