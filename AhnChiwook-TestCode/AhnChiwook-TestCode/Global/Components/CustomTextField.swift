//
//  CustomTextField.swift
//  AhnChiWook_assignment
//
//  Created by 안치욱 on 10/31/25.
//


import UIKit
import SnapKit
import Then

final class CustomTextField: UITextField {
    
    enum FieldType {
        case email
        case password
    }
    
    private let type: FieldType
    private lazy var textField = UITextField()
    private let placeholderLabel = UILabel()
    private lazy var clearButton = UIButton(type: .system)
    private lazy var secureButton = UIButton(type: .system)
    private var isSecureVisible = false
    
    
    // MARK: - Init
    
    init(type: FieldType, placeholder: String) {
        self.type = type
        super.init(frame: .zero)
        setupUI(placeholder: placeholder)
        setupLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    private func setupUI(placeholder: String) {
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor.baeminGray200.cgColor
        backgroundColor = .baeminWhite
        
        placeholderLabel.text = placeholder
        placeholderLabel.font = .body_r_14
        placeholderLabel.textColor = .baeminGray700
        
        textField.borderStyle = .none
        textField.font = .body_r_14
        textField.textColor = .baeminBlack
        textField.autocapitalizationType = .none
        textField.tintColor = .baeminMint500
        textField.isSecureTextEntry = (type == .password)
        
        clearButton.setImage(.clear, for: .normal)
        clearButton.isHidden = true
        
        secureButton.setImage(.eyeSlash, for: .normal)
        secureButton.isHidden = (type != .password)
        
        addSubviews(
            placeholderLabel,
            textField,
            clearButton,
            secureButton
        )
    }
    
    private func setupLayout() {
        placeholderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(type == .password ? 70 : 40)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        clearButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            if type == .password {
                $0.trailing.equalTo(secureButton.snp.leading).offset(-12)
            } else {
                $0.trailing.equalToSuperview().inset(12)
            }
            $0.size.equalTo(20)
        }
        
        if type == .password {
            secureButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(12)
                $0.size.equalTo(20)
            }
        }
    }
    
    private func setupActions() {
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.addTarget(self, action: #selector(beginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(tfEndEditing), for: .editingDidEnd)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        secureButton.addTarget(self, action: #selector(toggleSecure), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    
    @objc private func textDidChange() {
        clearButton.isHidden = textField.text?.isEmpty ?? true
    }
    
    @objc private func beginEditing() {
        animatePlaceholder(up: true)
        layer.borderColor = UIColor.baeminBlack.cgColor
        layer.borderWidth = 2
    }
    
    @objc private func tfEndEditing() {
        if textField.text?.isEmpty ?? true {
            animatePlaceholder(up: false)
        }
        layer.borderColor = UIColor.baeminGray200.cgColor
        layer.borderWidth = 1
    }
    
    @objc private func clearText() {
        textField.text = ""
        clearButton.isHidden = true
    }
    
    @objc private func toggleSecure() {
        isSecureVisible.toggle()
        textField.isSecureTextEntry = !isSecureVisible
        secureButton.setImage(isSecureVisible ? .eye : .eyeSlash, for: .normal)
    }
    
    private func animatePlaceholder(up: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.placeholderLabel.transform = up
            ? CGAffineTransform(translationX: 0, y: -20).scaledBy(x: 0.8, y: 0.8)
            : .identity
            self.placeholderLabel.textColor = up ? .baeminMint500 : .baeminGray700
        }
    }
    
    
    // MARK: - Public
    
    override var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    func reset() {
        textField.text = nil
        clearButton.isHidden = true
        if type == .password {
            secureButton.setImage(.eyeSlash, for: .normal)
            textField.isSecureTextEntry = true
            isSecureVisible = false
        }
        animatePlaceholder(up: false)
    }
}
