//
//  LoginViewController.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/31/25.
//

import UIKit

import Then
import SnapKit

final class LoginViewController: BaseUIViewController {
    private let navigationBar = BaeminNavigationBar(title: "이메일 또는 아이디로 계속")
    lazy var idTextField = BaeminIdTextField()
    private lazy var passwordTextField = BaeminPasswordTextField()
    
    private lazy var loginButton = BaeminButton().then {
        $0.text = "로그인"
        $0.isDisabled = true
    }
    
    private let findAccountButton = AccountButton()
    
    private lazy var toastMesssage = ToastMessage(title: "뿡").then {
        $0.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        idTextField.reset()
        passwordTextField.reset()
        passwordTextField.clearText()
        
        loginButton.isDisabled = true
    }
    
    override func setUI() {
        view.addSubviews(navigationBar, idTextField, passwordTextField, loginButton, findAccountButton, toastMesssage)
    }
    
    override func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(45)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        findAccountButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        toastMesssage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(116)
        }
    }
    
    override func addTarget() {
        idTextField.textField.addTarget(self, action: #selector(readyToLogin), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(readyToLogin), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    }
}

extension LoginViewController {
    @objc private func readyToLogin() {
        loginButton.isDisabled = (idTextField.textField.text?.isEmpty ?? true) || (passwordTextField.textField.text?.isEmpty ?? true)
    }
    
    @objc private func loginButtonDidTap() {
        guard let email = idTextField.textField.text,
              let password = passwordTextField.textField.text else {return}
        
        print("[\(email)] count=\(email.count)")
        
        if !email.isValidEmail {
            toastMesssage.updateTitle("이메일 형식이 다릅니다.")
            makeToast()
            return
        }
        if !password.isValidPassword {
            toastMesssage.updateTitle("비밀번호 형식이 다릅니다.")
            makeToast()
            return
        }
        
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.email = idTextField.textField.text
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    public func makeToast(){
        toastMesssage.alpha = 0
        toastMesssage.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.toastMesssage.alpha = 1.0
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 2){
                self.toastMesssage.alpha = 0
            } completion: { _ in
                self.toastMesssage.isHidden = true
            }
        }
    }
}
