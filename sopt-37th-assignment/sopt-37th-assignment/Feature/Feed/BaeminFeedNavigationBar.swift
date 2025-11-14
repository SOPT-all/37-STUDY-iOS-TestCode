//
//  BaeminFeedNavigationBar.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 11/5/25.
//

import UIKit

final class BaeminFeedNavigationBar: BaseView {
    private let homeLabel = UILabel()
    private let dropIconButton = UIButton()
    private let iconStackView = UIStackView()
    private let discountButton = UIButton()
    private let alarmButton = UIButton()
    private let cartButton = UIButton()
    
    override func setUI() {
        addSubviews(homeLabel, dropIconButton, iconStackView)
        iconStackView.addArrangedSubviews(discountButton, alarmButton, cartButton)
    }
    
    override func setStyle() {
        homeLabel.do {
            $0.text = "우리 집"
            $0.font = FontManager.headB16.font
            $0.textColor = .baeminBlack
        }
        
        dropIconButton.do {
            $0.setImage(.drop, for: .normal)
        }
        
        iconStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
        }
        
        discountButton.do {
            $0.setImage(.discount, for: .normal)
        }
        
        alarmButton.do {
            $0.setImage(.alarm, for: .normal)
        }
        
        cartButton.do {
            $0.setImage(.cart, for: .normal)
        }
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        
        homeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        dropIconButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(homeLabel.snp.trailing).offset(3)
            $0.width.equalTo(8)
            $0.height.equalTo(5)
        }
        
        iconStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
    }
}
