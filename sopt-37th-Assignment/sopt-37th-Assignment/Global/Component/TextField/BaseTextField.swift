//
//  BaseTextField.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/31/25.
//

import UIKit

import Then
import SnapKit

class BaseTextField: BaseUIView {
    
    // MARK: - Properties
    
    private let floatingLabel = UILabel()
    let textField = UITextField()
    
    private let text: String
    private let placeholderText: String
    
    
    // MARK: - Init
    
    init(text: String, placeholderText: String) {
        self.text = text
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        floatingLabel.text = text
        textField.placeholder = placeholderText
        setUI()
        setLayout()
    }

    
    // MARK: - SetUI
    
    override func setUI() {
        floatingLabel.do {
            $0.font = .caption_r_10
            $0.textColor = .baeminGray700
            $0.alpha = 0
            $0.backgroundColor = .white
        }
        
        textField.do {
            $0.font = .body_r_14
            $0.textColor = .baeminGray700
            $0.tintColor = .baeminMint300
            $0.addPadding()
            $0.setPlaceholder(color: UIColor.baeminGray700)
            $0.layer.cornerRadius = 4
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.baeminGray200.cgColor
            $0.delegate = self
        }
    }
    
    
    // MARK: - SetLayout
    
    override func setLayout() {
        addSubviews(textField, floatingLabel)
        
        textField.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(46)
        }
        
        floatingLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalTo(textField.snp.top).offset(5)
        }
    }
}

extension BaseTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateFloat(isActive: true)
        animateFocus(isActive: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateFloat(isActive: true)
        animateFocus(isActive: false)
    }
}

extension BaseTextField {
    
    // MARK: - Function
    
    private func animateFloat(isActive: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.floatingLabel.alpha = isActive ? 1 : 0
            self.floatingLabel.transform = isActive ? CGAffineTransform(translationX: 0, y: -10) : .identity
        }
    }
    
    private func animateFocus(isActive: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.textField.layer.borderColor = isActive ? UIColor.baeminBlack.cgColor : UIColor.baeminGray200.cgColor
            self.textField.layer.borderWidth = isActive ? 2 : 1
        }
    }
    
    func reset() {
        textField.text = ""
        animateFloat(isActive: false)
        animateFocus(isActive: false)
    }
}
