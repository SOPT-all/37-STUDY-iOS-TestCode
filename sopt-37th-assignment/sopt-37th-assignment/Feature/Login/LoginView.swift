//
//  LoginView.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/23/25.
//

import UIKit

final class LoginView: BaseView {
    private let navigationBar = BaeminNavigationBar(title: "이메일 또는 아이디로 계속")
    private(set) var idTextField = BaeminTextField(textfieldType: .email)
    private(set) var passwordTextField = BaeminTextField(textfieldType: .password)
    private(set) lazy var loginButton = BaeminButton(style: .smallNormal, title: "로그인")
    private(set) var findIDView = UIStackView()
    private let findIDLabel = UILabel()
    private let findIDIcon = UIImageView()
    private(set) var nameLabel = UILabel()
    
    override func setStyle() {
        backgroundColor = .baeminWhite
        
        findIDView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
        
        findIDLabel.do {
            $0.text = "계정 찾기"
            $0.font = FontManager.bodyR14.font
            $0.textColor = .baeminBlack
        }
        
        findIDIcon.do {
            $0.image = .chevronRight
            $0.contentMode = .scaleAspectFit
        }
        
        nameLabel.do {
            $0.font = FontManager.bodyR14.font
            $0.textColor = .baeminBlack
        }
    }
    
    override func setUI() {
        addSubviews(navigationBar, idTextField, passwordTextField, loginButton, findIDView, nameLabel)
        findIDView.addArrangedSubviews(findIDLabel, findIDIcon)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
            $0.height.equalTo(42)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        findIDView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(findIDView.snp.bottom).offset(38)
            $0.centerX.equalToSuperview()
        }
    }
}
