//
//  WelcomeViewController.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/31/25.
//

import UIKit

import Then
import SnapKit

class WelcomeViewController: BaseUIViewController {
    var email: String? = ""
    
    private let navigationBar = BaeminNavigationBar(title: "대체 뼈찜 누가 시켰어??")
    
    private let baeminImage = UIImageView().then{
        $0.image = .surprisedCharacter
        $0.contentMode = .scaleAspectFit
    }
    
    private let welcomeLabel = UILabel().then{
        $0.text = "환영합니다"
        $0.font = .head_b_24
        $0.textColor = .baeminBlack
    }
    
    private lazy var emailLabel = UILabel().then{
        $0.text = "\(email ?? "뿡")님 반가워요!"
        $0.font = .head_b_24
        $0.textColor = .baeminBlack
    }
    
    private lazy var backButton = BaeminButton().then{
        $0.text = "뒤로가기"
    }
    
    override func setUI() {
        view.addSubviews(navigationBar, baeminImage, welcomeLabel, emailLabel, backButton)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(45)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        baeminImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(navigationBar.snp.bottom).offset(6)
            $0.height.equalTo(211)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(baeminImage.snp.bottom).offset(24)
        }
        
        emailLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(16)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(48)
        }
    }
    
    override func addTarget() {
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
}

extension WelcomeViewController {
    @objc private func backButtonDidTap() {
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
