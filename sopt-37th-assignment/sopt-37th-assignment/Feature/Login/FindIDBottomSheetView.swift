//
//  FindIDBottomSheetView.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/25/25.
//

import UIKit

import SnapKit
import Then

final class FindIDBottomSheetView: UIView {
    private let titleLabel = UILabel()
    private(set) var textField = UITextField()
    private(set) var confirmButton = BaeminButton(style: .smallNormal, title: "로그인")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(titleLabel, textField, confirmButton)
    }
    
    private func setStyle() {
        backgroundColor = .bottomsheetGray
        
        titleLabel.do {
            $0.text = "이메일을 입력해주세요"
            $0.font = FontManager.titleSb18.font
            $0.textColor = .baeminBlack
        }
        
        textField.do {
            $0.layer.cornerRadius = 3
            $0.textColor = .baeminBlack
            $0.addPadding()
            $0.font = FontManager.bodyR14.font
            $0.backgroundColor = .baeminWhite
        }
        
        confirmButton.do {
            $0.isEnabled = false
        }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33)
            $0.leading.equalToSuperview().inset(17)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(46)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(38)
            $0.leading.trailing.equalToSuperview().inset(16.5)
        }
    }
    
}
