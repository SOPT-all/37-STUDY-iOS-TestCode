//
//  WelcomeView.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/25/25.
//

import UIKit

final class WelcomeView: BaseView {
    private(set) var navigationBar = BaeminNavigationBar(title: "로그인 완료")
    private let welcomeImage = UIImageView()
    private let welcomeLabel = UILabel()
    private let nameLabel = UILabel()
    private(set) lazy var backButton = BaeminButton(style: .LongSelected, title: "뒤로 가기")
    
    override func setUI() {
        addSubviews(navigationBar, welcomeImage, welcomeLabel, nameLabel, backButton)
    }
    
    override func setStyle() {
        backgroundColor = .baeminWhite
        
        welcomeImage.do {
            $0.image = .welcome
            $0.contentMode = .scaleAspectFill
        }
        
        welcomeLabel.do {
            $0.text = "환영합니다"
            $0.font = FontManager.headB24.font
            $0.textColor = .baeminBlack
        }
        
        nameLabel.do {
            $0.text = "??님 반가워요!"
            $0.font = FontManager.headB18.font
            $0.textColor = .baeminBlack
        }
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
            $0.height.equalTo(42)
        }
        
        welcomeImage.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeImage.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func bindName(name: String) {
        nameLabel.text = "\(name)님 반가워요!"
    }
}
