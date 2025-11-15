//
//  BaeminPasswordTextField.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/31/25.
//

import UIKit

import Then
import SnapKit

final class BaeminPasswordTextField: BaseTextField {
    
    // MARK: - Properties
    
    private lazy var clearButton = UIButton().then {
        $0.setImage(.cancle, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }
    
    private lazy var eyeButton = UIButton().then {
        $0.setImage(.eye, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(toggleEye), for: .touchUpInside)
    }
    
    
    // MARK: - Init
    
    override init(text: String = "비밀번호", placeholderText: String = "비밀번호") {
        super.init(text: text, placeholderText: placeholderText)
        setStyle()
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - SetUI
    
    private func setStyle() {
        addSubviews(clearButton, eyeButton)
        textField.isSecureTextEntry = true
        
        eyeButton.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.trailing.equalTo(textField.snp.trailing).inset(20)
        }
        
        clearButton.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.trailing.equalTo(eyeButton.snp.leading).offset(-16)
        }
    }
}

extension BaeminPasswordTextField {
    @objc func clearText() {
        textField.text = ""
        clearButton.isHidden = true
        eyeButton.isHidden = true
    }
    
    @objc private func toggleEye() {
        textField.isSecureTextEntry.toggle()
        eyeButton.setImage(textField.isSecureTextEntry ? .eyeSlash : .eye, for: .normal)
    }
    
    @objc private func textDidChange() {
        let hasText = !(textField.text?.isEmpty ?? true)
        clearButton.isHidden = !hasText
        eyeButton.isHidden = !hasText
    }
}
