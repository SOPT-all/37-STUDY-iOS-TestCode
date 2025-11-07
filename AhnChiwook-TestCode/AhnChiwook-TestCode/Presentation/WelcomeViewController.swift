//
//  WelcomeViewController.swift
//  AhnChiWook_assignment
//
//  Created by 안치욱 on 10/27/25.
//

import UIKit

import SnapKit
import Then

final class WelcomeViewController: BaseViewController {
    
    
    // MARK: - Properties
    
    var loginDataCompletion: (() -> Void)?
    
    var email: String?
    
    private let naviBar = CustomNavigationBar()
    
    private let welcomeImage = UIImageView().then {
        $0.image = .image21
    }
    
    private let welcomeLabel = UILabel().then {
        $0.text = "환영합니다"
        $0.font = .head_b_24
        $0.textColor = .baeminBlack
    }
    
    private let hiLabel = UILabel().then {
        $0.text = "익명의 사용자님 반가워요!"
        $0.font = .title_sb_18
        $0.textColor = .baeminBlack
    }
    
    private lazy var backButton = UIButton().then {
        $0.setTitle("뒤로가기", for: .normal)
        $0.backgroundColor = .baeminMint500
        $0.titleLabel?.font = .title_sb_18
        $0.setTitleColor(.baeminWhite, for: .normal)
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    
    // MARK: - Setting Method
    
    override func setStyle() {
        naviBar.setTitle("대체 뼈찜 누가 시켰어??")
        bindEmail()
    }
    
    override func setUI() {
        view.addSubviews(
            naviBar,
            welcomeImage,
            welcomeLabel,
            hiLabel,
            backButton
        )
    }
    
    override func setLayout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        welcomeImage.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeImage.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        hiLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
    
    
    // MARK: - Method
    
    private func bindEmail() {
        guard let email else { return }
        hiLabel.text = "\(email)님 반가워요!"
    }
    
    @objc
    private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
        loginDataCompletion?()
    }
}
