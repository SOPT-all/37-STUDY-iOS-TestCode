//
//  FindAccountViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.28.
//

import SnapKit

import UIKit

class FindAccountViewController: UIViewController {
    
    // MARK: - Variable
    var applyEmailToLoginViewController: ((String?) -> Void)?
    
    // MARK: - Component
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입력해주세요"
        label.font = .pretendard(.title_sb_18)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .baeminWhite
        textField.layer.cornerRadius = 3
        textField.addLeftPadding(22)
        textField.clearButtonMode = .whileEditing
        textField.spellCheckingType = .no
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.inlinePredictionType = .no
        textField.smartDashesType = .no
        textField.smartQuotesType = .no
        textField.smartInsertDeleteType = .no
        textField.addTarget(self, action: #selector(editingChangedEmailTextField), for: .editingChanged)
        return textField
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = .baeminGray200
        button.setTitleColor(.baeminWhite, for: .normal)
        button.setTitle("확인", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .pretendard(.head_b_18)
        button.addTarget(self, action: #selector(onClickOkButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Component Action
    @objc private func editingChangedEmailTextField(_ sender: UITextField) {
        let hasText: Bool = !(sender.text?.isEmpty ?? true)
        okButton.isEnabled = hasText
        okButton.backgroundColor = hasText ? .baeminMint500 : .baeminGray200
    }
    @objc private func onClickOkButton() {
        applyEmailToLoginViewController?(emailTextField.text)
        dismiss(animated: true)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Configure
    private func configureView() {
        view.backgroundColor = .baeminGray300
        
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(okButton)
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().inset(33)
            $0.leading.equalToSuperview().inset(17)
        })
        emailTextField.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(33)
            $0.leading.equalToSuperview().inset(17)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(46)
        })
        okButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().inset(38)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(46)
        })
    }
}
