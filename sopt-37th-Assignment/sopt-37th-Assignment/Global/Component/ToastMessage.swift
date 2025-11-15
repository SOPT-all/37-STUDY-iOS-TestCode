//
//  ToastMessage.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/31/25.
//

import UIKit

import Then
import SnapKit

final class ToastMessage: BaseUIView {
    
    // MARK: - Properties
    
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
        backgroundColor = .baeminBlack.withAlphaComponent(0.6)
        layer.cornerRadius = 4
        clipsToBounds = true
        
        addSubviews(titleLabel)
        
        titleLabel.do {
            $0.textAlignment = .center
            $0.textColor = .baeminWhite
            $0.font = .body_r_14
            $0.text = title
        }
    }
    
    
    // MARK: - SetLayout
    
    override func setLayout() {
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func updateTitle(_ newTitle: String) {
        titleLabel.text = newTitle
    }
}
