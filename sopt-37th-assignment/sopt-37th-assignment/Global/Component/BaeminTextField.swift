//
//  BaeminTextField.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/24/25.
//

import UIKit

import SnapKit
import Then

enum BaeminTextFieldStyle {
    case normal
    case selected
    
    var textColor: UIColor {
        return .baeminBlack
    }
    
    var backgroundColor: UIColor {
        return .clear
    }
    
    var borderColor: UIColor {
        switch self {
        case .normal:
            return .baeminGray200
        case .selected:
            return .baeminBlack
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .normal:
            return 1
        case .selected:
            return 2
        }
    }
}

enum BaeminTextFieldType {
    case email
    case password
    
    var label: String {
        switch self {
        case .email:
            return "이메일 아이디"
        case .password:
            return "비밀번호"
        }
    }
    
    var placeholder: String {
        switch self {
        case .email:
            return "이메일 또는 아이디를 입력해 주세요"
        case .password:
            return "비밀번호"
        }
    }
}

final class BaeminTextField: UIView {
    private let type: BaeminTextFieldType
    private let style: BaeminTextFieldStyle
    private(set) var textField = UITextField()
    private let label = UILabel()
    private let labelBackground = UIView()
    
    private let trailingStackView = UIStackView()
    private let eyeButton: UIButton?
    private let clearButton = UIButton()
    private var isSecure = true
    
    init(
        textfieldType: BaeminTextFieldType,
        style: BaeminTextFieldStyle = .normal
    ) {
        self.type = textfieldType
        self.style = style
        
        if type == .password {
            eyeButton = UIButton()
        } else {
            eyeButton = nil
        }
        
        super.init(frame: .zero)
        
        textField.delegate = self
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(textField, labelBackground, trailingStackView, label)
        trailingStackView.addArrangedSubviews(clearButton)
        
        if let eyeButton = eyeButton {
            trailingStackView.addArrangedSubviews(eyeButton)
        }
    }
    
    private func setStyle(){
        textField.do {
            $0.backgroundColor = style.backgroundColor
            $0.layer.borderColor = style.borderColor.cgColor
            $0.textColor = style.textColor
            $0.layer.borderWidth = style.borderWidth
            $0.font = FontManager.bodyR14.font
            $0.layer.cornerRadius = 4
            $0.addPadding()
            
            if type == .password {
                $0.isSecureTextEntry = true
            }
        }
        
        label.do {
            $0.text = type.label
            $0.textColor = .baeminGray700
            $0.font = FontManager.bodyR14.font
        }
        
        labelBackground.do {
            $0.backgroundColor = .baeminWhite
            $0.isHidden = true
        }
        
        trailingStackView.do {
            $0.spacing = 16
            $0.axis = .horizontal
            $0.isHidden = true
        }
        
        if let eyeButton = eyeButton {
            eyeButton.setImage(.eye, for: .normal)
            eyeButton.addTarget(self, action: #selector(eyeButtonDidTap), for: .touchUpInside)
        }
        
        clearButton.do {
            $0.setImage(.cancle , for: .normal)
            $0.addTarget(self, action: #selector(clearButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(46)
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(46)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        labelBackground.snp.makeConstraints {
            $0.leading.equalTo(textField.snp.leading).offset(10)
            $0.top.equalTo(textField.snp.top).offset(-5)
            $0.height.equalTo(10)
            $0.width.equalTo(label.snp.width).offset(8)
        }
        
        trailingStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
}

extension BaeminTextField {
    func resetStyle() {
        updateTextFieldStyle(style: .normal)
        updateLabelStyle(isStartEditing: false)
        textField.text = ""
    }
    
    private func updateTextFieldStyle(style: BaeminTextFieldStyle) {
        textField.do {
            $0.backgroundColor = style.backgroundColor
            $0.layer.borderColor = style.borderColor.cgColor
            $0.textColor = style.textColor
            $0.layer.borderWidth = style.borderWidth
            $0.tintColor = .baeminMint300
            $0.placeholder = style == .selected ? type.placeholder : .none
            $0.setPlaceholder(color: .baeminGray700)
        }
    }
    
    private func updateLabelStyle(isStartEditing: Bool) {
        if isStartEditing {
            trailingStackView.do {
                $0.isHidden = false
            }
            
            label.do {
                $0.font = FontManager.captionR10.font
                $0.clipsToBounds = false
                $0.backgroundColor = .baeminWhite
            }
            
            labelBackground.do {
                $0.isHidden = false
            }
            
            label.snp.remakeConstraints {
                $0.leading.equalTo(labelBackground.snp.leading).offset(4)
                $0.top.equalTo(textField.snp.top).offset(-5)
            }
        } else {
            label.do {
                $0.textColor = .baeminGray700
                $0.font = FontManager.bodyR14.font
            }
            
            labelBackground.do {
                $0.isHidden = true
            }
            
            label.snp.remakeConstraints {
                $0.leading.equalToSuperview().inset(10)
                $0.centerY.equalToSuperview()
            }
        }
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc
    private func clearButtonDidTap() {
        textField.text = ""
    }
    
    @objc
    private func eyeButtonDidTap() {
        isSecure.toggle()
        textField.isSecureTextEntry = isSecure
        let eyeButtonImage = isSecure ? "eye" : "eye_slash"
        if let eyeButton = eyeButton {
            eyeButton.setImage(UIImage(named: eyeButtonImage), for: .normal)
        }
    }
}

extension BaeminTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateTextFieldStyle(style: .selected)
        updateLabelStyle(isStartEditing: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateTextFieldStyle(style: .normal)
        trailingStackView.isHidden = true
        guard let text = textField.text else { return }
        if text.isEmpty {
            updateLabelStyle(isStartEditing: false)
        }
    }
}
