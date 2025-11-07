//
//  LoginViewController.swift
//  Baemin
//
//  Created by 진소은 on 10/28/25.
//

import UIKit

import SnapKit
import Then

class LoginViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar(title: "이메일 또는 아이디로 계속")
    private let idTextField = UITextField()
    private let passwordStackView = UIStackView()
    private let passwordTextField = UITextField()
    private let clearButton = UIButton()
    private let secureButton = UIButton()
    private let loginButton = CTAButton()
    private let findAccountStackView = UIStackView()
    private let findAccountLabel = UILabel()
    private let detailButton = UIButton()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        idTextField.text = ""
        passwordTextField.text = ""
        loginButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setTextFieldActions()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        view.backgroundColor = .white
        
        idTextField.do {
            $0.textColor = .baeminBlack
            $0.font = .pretendard(.body_r_14)
            $0.addPadding(10)
            $0.placeholder = "이메일 아이디"
            $0.setPlaceholder(color: .baeminGray700)
            $0.borderStyle = .none
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(.baeminGray200).cgColor
            $0.layer.cornerRadius = 4
        }
        
        passwordStackView.do {
            $0.axis = .horizontal
            $0.spacing = 16
            $0.alignment = .center
        }
        
        passwordTextField.do {
            $0.textColor = .baeminBlack
            $0.font = .pretendard(.body_r_14)
            $0.addPadding(10)
            $0.placeholder = "비밀번호"
            $0.setPlaceholder(color: .baeminGray700)
            $0.borderStyle = .none
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(.baeminGray200).cgColor
            $0.layer.cornerRadius = 4
            $0.isSecureTextEntry = true
        }
        
        clearButton.do {
            $0.setImage(.icClear, for: .normal)
            $0.isHidden = true
            $0.addTarget(self, action: #selector(clearButtonDidTapped), for: .touchUpInside)
        }
        
        secureButton.do {
            $0.setImage(.icEyeHide, for: .normal)
            $0.isHidden = true
            $0.addTarget(self, action: #selector(secureButtonDidTapped), for: .touchUpInside)
        }
        
        loginButton.configure(style: .inactive, title: "로그인")
        loginButton.do {
            $0.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        }
        
        findAccountLabel.do {
            $0.text = "계정 찾기"
            $0.font = .pretendard(.body_r_14)
            $0.textColor = .baeminBlack
        }
        
        detailButton.do {
            $0.setImage(.icChevronRight, for: .normal)
        }
        
        findAccountStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
        }
    }
    
    // MARK: - Set Layout
    
    private func setLayout() {
        view.addSubviews(navigationBar, idTextField, passwordTextField, passwordStackView, loginButton, findAccountStackView)
        passwordStackView.addArrangedSubviews(clearButton, secureButton)
        findAccountStackView.addArrangedSubviews(findAccountLabel, detailButton)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(66)
            $0.height.equalTo(46)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.height.equalTo(46)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        passwordStackView.snp.makeConstraints {
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(20)
            $0.centerY.equalTo(passwordTextField)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.height.equalTo(46)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        findAccountStackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Override
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Private Methods
    
    private func setTextFieldActions() {
        [idTextField, passwordTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            $0.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
            $0.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        }
    }
    
    private func pushToWelcomeVC() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.setName(name: idTextField.text)
        self.navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    // MARK: - Actions
    
    @objc
    func clearButtonDidTapped() {
        passwordTextField.text = ""
        loginButton.isEnabled = false
    }
    
    @objc
    func secureButtonDidTapped() {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
            secureButton.setImage(.icEyeOpen, for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            secureButton.setImage(.icEyeHide, for: .normal)
        }
    }
    
    @objc
    func loginButtonDidTapped() {
        if idTextField.text?.isValidEmail == false {
            let alertController = UIAlertController(
                title: "알림",
                message: "이메일 형식을 확인하세요",
                preferredStyle: .alert
            )
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alertController.addAction(ok)
            present(alertController, animated: true)
        } else if passwordTextField.text?.isValidPassword == false {
            let alertController = UIAlertController(
                title: "알림",
                message: "비밀번호 형식을 확인하세요\n8~16자 영문, 숫자, 특수문자 조합",
                preferredStyle: .alert
            )
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alertController.addAction(ok)
            present(alertController, animated: true)
        } else {
            pushToWelcomeVC()
            view.endEditing(true)
        }
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        let idText = idTextField.text ?? ""
        let pwText = passwordTextField.text ?? ""
        loginButton.isEnabled = !idText.isEmpty && !pwText.isEmpty
    }
    
    @objc
    func textFieldEditingDidBegin(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.baeminBlack.cgColor
        if (textField == passwordTextField) {
            clearButton.isHidden = false
            secureButton.isHidden = false
        }
    }
    
    @objc
    func textFieldEditingDidEnd(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.baeminGray200.cgColor
        if (textField == passwordTextField) {
            clearButton.isHidden = true
            secureButton.isHidden = true
        }
    }
}

extension String {
    var isValidEmail: Bool {
        let regularExpression = "^[A-Z0-9a-z._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regularExpression = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
}

#Preview {
    LoginViewController()
}
