//
//  BaeminIdTextField.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/31/25.
//

import UIKit

final class BaeminIdTextField: BaseTextField {
    override init(text: String = "이메일 아이디", placeholderText: String = "이메일 또는 아이디를 입력해 주세요") {
        super.init(text: text, placeholderText: placeholderText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
