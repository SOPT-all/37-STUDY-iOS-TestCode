//
//  AnimatedTextField.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.22.
//

import SnapKit

import UIKit

final class AnimatedTextField: UIView {
    
    var font: UIFont? = .pretendard(.body_r_14)
    var animatedPlaceholderFont: UIFont? = .pretendard(.caption_r_10)
    var textColor: UIColor = .baeminBlack
    var placeholderColor: UIColor = .baeminGray700
    var placeholder: String?
    var animatedPlaceholder: String?
    
    lazy var animatedPlaceholderLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = ""
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(editingChangedTextField), for: .editingChanged)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textField)
        addSubview(animatedPlaceholderLabel)
        
        textField.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        animatedPlaceholderLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        })
        
        bringSubviewToFront(animatedPlaceholderLabel)
        
        textField.addLeftPadding(10)
        textField.font = font
        textField.textColor = textColor
        
        animatedPlaceholderLabel.font = font
        animatedPlaceholderLabel.textColor = placeholderColor
        animatedPlaceholderLabel.text = animatedPlaceholder
        
        textField.layer.borderColor = UIColor.baeminGray200.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
    }
    
    func configure(placeholder: String, animatedPlaceholder: String) {
        self.placeholder = placeholder
        self.animatedPlaceholder = animatedPlaceholder
        animatedPlaceholderLabel.text = animatedPlaceholder
    }
    
    func addSecurityButton() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        stackView.isHidden = true
        
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(resource: .cancel), for: .normal)
        cancelButton.addTarget(self, action: #selector(onClickCancelButton), for: .touchUpInside)
        cancelButton.snp.makeConstraints({
            $0.size.equalTo(24)
        })
        
        let securityButton = UIButton()
        securityButton.setImage(UIImage(resource: .eye), for: .normal)
        securityButton.setImage(UIImage(resource: .eyeSlash), for: .selected)
        securityButton.addTarget(self, action: #selector(onClickSecurityButton), for: .touchUpInside)
        securityButton.snp.makeConstraints({
            $0.size.equalTo(20)
        })
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(securityButton)
        
        textField.rightView = stackView
        textField.rightViewMode = .always
    }
    
    @objc private func editingChangedTextField() {
        let hasText: Bool = !(textField.text?.isEmpty ?? true)
        textField.rightView?.isHidden = !hasText
    }
    
    @objc private func onClickCancelButton() {
        textField.text = nil
        setFocused(false)
    }
    
    @objc private func onClickSecurityButton(_ sender: UIButton) {
        textField.isSecureTextEntry = sender.isSelected
        sender.isSelected.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFocused(_ isFocused: Bool) {
        textField.sendActions(for: .editingChanged)
        let hasText: Bool = !(textField.text?.isEmpty ?? true)
        
        let borderColor: CGColor = isFocused ? UIColor.baeminBlack.cgColor : UIColor.baeminGray200.cgColor
        let borderWidth: CGFloat = isFocused ? 2 : 1
        let labelBackgroundColor: UIColor = isFocused || hasText ? .baeminWhite : .clear
        let textFieldPlaceholderColor: UIColor = isFocused ? placeholderColor : .clear
        let labelPadding: UIEdgeInsets? = isFocused || hasText ? UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4) : nil
        
        let fromFont: UIFont? = isFocused ? font : animatedPlaceholderFont
        let toFont: UIFont? = isFocused ? animatedPlaceholderFont : font
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self else { return }
            textField.layer.borderColor = borderColor
            textField.layer.borderWidth = borderWidth
            animatedPlaceholderLabel.backgroundColor = labelBackgroundColor
            
            textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: textFieldPlaceholderColor])
            
            animatedPlaceholderLabel.snp.remakeConstraints({ [weak self] in
                guard let self else { return }
                $0.leading.equalToSuperview().inset(10)
                
                if isFocused || hasText {
                    $0.centerY.equalTo(snp.top)
                } else {
                    $0.centerY.equalToSuperview()
                }
            })
            layoutIfNeeded()
            if let fromFont, let toFont, !hasText {
                let scale = toFont.pointSize / fromFont.pointSize
                let originWidth = animatedPlaceholderLabel.bounds.width
                let padding: CGFloat = isFocused ? 4 : -4 * scale
                animatedPlaceholderLabel.transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: ((scale-1)*originWidth / 2 + padding) / scale, y: 0)
            }
        }, completion: { [weak self] _ in
            guard let self else { return }
            if !hasText {
                animatedPlaceholderLabel.transform = .identity
                animatedPlaceholderLabel.font = toFont
                animatedPlaceholderLabel.padding = labelPadding
            }
        })
    }
}
