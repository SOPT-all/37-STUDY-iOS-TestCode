//
//  CustomNavigationBar.swift
//  Baemin
//
//  Created by 진소은 on 10/29/25.
//

import UIKit

import SnapKit
import Then

final class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    var onBackButtonTapped: (() -> Void)?
    
    // MARK: - UI Components
    
    private lazy var backButton = UIButton()
    private let titleLabel = UILabel()
    
    // MARK: - Init
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        addSubviews(backButton,titleLabel)
        
        backButton.do {
            $0.setImage(.icArrowLeft, for: .normal)
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
        
        titleLabel.do {
            $0.textColor = .baeminBlack
            $0.font = .pretendard(.title_sb_18)
            $0.textAlignment = .center
        }
    }
    
    // MARK: - Set Layout
    
    private func setLayout() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    @objc
    private func backButtonDidTap() {
        onBackButtonTapped?()
    }
}
