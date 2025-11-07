//
//  CustomNavigationBar.swift
//  AhnChiWook_assignment
//
//  Created by 안치욱 on 10/30/25.
//


import UIKit

import SnapKit
import Then

final class CustomNavigationBar: UIView {
    
    
    // MARK: - UI
    
    private let titleLabel = UILabel().then {
        $0.font = .title_sb_18
        $0.textColor = .baeminBlack
        $0.textAlignment = .center
    }
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "btn_back"), for: .normal)
    }
    
    
    // MARK: - Properties
    
    var onBackButtonTap: (() -> Void)?
    var onRightButtonTap: (() -> Void)?
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .baeminWhite
        setLayout()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Set
    
    private func setLayout() {
        //backgroundColor = .systemBackground
        
        addSubviews(
            backButton,
            titleLabel
        )
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.top.equalTo(safeAreaLayoutGuide).offset(3)
            $0.width.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backButton)
        }

    }
    
    private func setActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Action Handlers
    
    @objc private func backButtonTapped() {
        onBackButtonTap?()
        print("back button tapped")
    }
    
    
    // MARK: - Public Methods
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
}
