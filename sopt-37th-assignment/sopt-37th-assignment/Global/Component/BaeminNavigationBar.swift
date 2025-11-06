//
//  BaeminNavigationBar.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/23/25.
//

import UIKit

import SnapKit
import Then

protocol BaeminNavigationBarDelegate: AnyObject {
    func backButtonDidTap()
}

final class BaeminNavigationBar: UIView {
    private(set) lazy var backButton = UIButton()
    private let titleLabel = UILabel()
    weak var delegate: BaeminNavigationBarDelegate?
    
    private let title: String
    
    init(
        title: String
    ) {
        self.title = title
        super.init(frame: .zero)
        
        setUI()
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(backButton, titleLabel)
    }
    
    private func setStyle() {
        backButton.do {
            $0.setBackgroundImage(.arrowLeft, for: .normal)
            $0.tintColor = .baeminBlack
            $0.contentMode = .scaleAspectFit
        }
        
        titleLabel.do {
            $0.text = title
            $0.font = FontManager.titleSb18.font
            $0.textColor = .baeminBlack
        }
    }
    
    private func setLayout() {
        self.backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(3)
            $0.width.height.equalTo(36)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
    }
}
