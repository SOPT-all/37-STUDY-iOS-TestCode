//
//  BaeminSearchBar.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 11/5/25.
//

import UIKit

final class BaeminSearchBar: BaseView {
    private let searchTextField = UITextField()
    private let searchButton = UIButton()
    
    override func setUI() {
        addSubviews(searchTextField, searchButton)
    }
    
    override func setStyle() {
        self.do {
            $0.backgroundColor = .baeminWhite
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.baeminBlack.cgColor
        }
        
        searchTextField.do {
            $0.placeholder = "찾아라! 맛있는 음식과 맛집"
            $0.setPlaceholder(color: .baeminGray300)
            $0.font = FontManager.bodyR14.font
        }
        
        searchButton.do {
            $0.setImage(.search, for: .normal)
        }
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(17)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-10)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
            $0.trailing.equalToSuperview().inset(17)
        }
    }

}
