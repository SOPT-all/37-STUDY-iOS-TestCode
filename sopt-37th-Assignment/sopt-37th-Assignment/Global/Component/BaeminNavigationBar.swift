//
//  BaeminNavigationBar.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/31/25.
//

import UIKit

import Then
import SnapKit

protocol BaeminNavigationBarDelegate: AnyObject {
    func didTapBackButton()
}

final class BaeminNavigationBar: BaseUIView {
    
    weak var delegate: BaeminNavigationBarDelegate?

    
    // MARK: - Properties
    
    private lazy var backButton = UIButton()
    private let titleLabel = UILabel()
    
    private var title: String
    
    
    // MARK: - Init
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - SetUI
    
    override func setUI() {
        addSubviews(backButton, titleLabel)
        
        backButton.do {
            $0.setImage(.arrowLeft, for: .normal)
            $0.tintColor = .baeminBlack
            $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        }
        
        titleLabel.do {
            $0.textColor = .baeminBlack
            $0.font = .title_sb_18
            $0.text = title
        }
    }
    
    
    // MARK: - SetLayout
    
    override func setLayout() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension BaeminNavigationBar {
    
    // MARK: - Function
    
    @objc func backButtonTapped() {
        delegate?.didTapBackButton()
    }
}
