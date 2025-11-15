//
//  AccountButton.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/31/25.
//

import UIKit

import Then
import SnapKit

public final class AccountButton: UIButton {
    
    // MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        configuration = .plain()
        
        var attributedTitle = AttributedString("계정 찾기")
        attributedTitle.font = .body_r_14
        attributedTitle.foregroundColor = .baeminBlack
        configuration?.attributedTitle = attributedTitle
        
        configuration?.image = .chevronRight
        configuration?.imagePlacement = .trailing
        configuration?.imagePadding = 4
        configuration?.baseForegroundColor = .baeminBlack
    }
}
