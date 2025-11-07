//
//  LoginViewController.swift
//  AhnChiWook_assignment
//
//  Created by 안치욱 on 10/26/25.
//

import UIKit

import SnapKit
import SkyFloatingLabelTextField
import Then
import Toast


final class LoginViewController: BaseViewController {
    
    
    // MARK: - Properties
    
    private lazy var naviBar = CustomNavigationBar().then {
        $0.setTitle("이메일 또는 아이디로 계속")
    }
    
//    private lazy var emailTextField = UITextField().then {
//        $0.placeholder = "이메일 또는 아이디를 입력해 주세요"
//        $0.setPlaceholderColor(.baeminGray700)
//        $0.font = .body_r_14
//        $0.backgroundColor = .baeminWhite
//        $0.clearButtonMode = .whileEditing
//        $0.addLeftPadding(10)
//        $0.autocapitalizationType = .none
//        $0.layer.cornerRadius = 4
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor.baeminGray200.cgColor
//        $0.textColor = .baeminBlack
//        $0.addTarget(self, action: #selector(updateLoginButtonState), for: .allEditingEvents)
//    }
    private lazy var emailTextField = makeTextField( placeholder: "이메일 또는 아이디를 입력해 주세요" )
    private lazy var passwordTextField = makeTextField( placeholder: "비밀번호", isSecure: true )

//    private lazy var passwordTextField = UITextField().then {
//        $0.placeholder = "비밀번호"
//        $0.setPlaceholderColor(.baeminGray700)
//        $0.font = .body_r_14
//        $0.backgroundColor = .baeminWhite
//        $0.addLeftPadding(10)
//        $0.isSecureTextEntry = true
//        $0.autocapitalizationType = .none
//        $0.layer.cornerRadius = 4
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor.baeminGray200.cgColor
//        $0.textColor = .baeminBlack
//        $0.addTarget(self, action: #selector(updateLoginButtonState), for: .allEditingEvents)
//    }
    
    private lazy var clearButton = UIButton().then {
        $0.setImage(.clear, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }
    
    private lazy var secureButton = UIButton().then {
        $0.setImage(.eyeSlash, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(secureButtonTapped), for: .touchUpInside)
    }
    
    private let rightView = UIView()
    
    private lazy var loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .baeminGray200
        $0.titleLabel?.font = .head_b_18
        $0.setTitleColor(.baeminWhite, for: .normal)
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        $0.isEnabled = false
    }
    
    private lazy var findAccountButtonView = UIView().then {
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(findAccountButtonDidTap)))
    }
    
    private let findAccountLabel = UILabel().then {
        $0.font = .body_r_14
        $0.textColor = .baeminBlack
        $0.text = "계정 찾기"
    }
    
    private let moreImageView = UIImageView().then {
        $0.image = .moreButton
    }
    
    override func setUI() {
        view.addSubviews(
            naviBar,
            emailTextField,
            passwordTextField,
            rightView,
            loginButton,
            findAccountButtonView
        )
        
        rightView.addSubviews(
            secureButton,
            clearButton
        )
        
        findAccountButtonView.addSubviews(
            findAccountLabel,
            moreImageView
        )
    }
    
    override func setLayout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(naviBar.snp.bottom).offset(24)
            $0.height.equalTo(46)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.height.equalTo(46)
        }
        
        rightView.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextField.snp.centerY)
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(20)
            $0.height.equalTo(20)
            $0.width.equalTo(56)
        }
        
        secureButton.snp.makeConstraints {
            $0.centerY.equalTo(rightView.snp.centerY)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        clearButton.snp.makeConstraints {
            $0.centerY.equalTo(rightView.snp.centerY)
            $0.trailing.equalTo(secureButton.snp.leading).offset(-16)
            $0.size.equalTo(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.height.equalTo(46)
        }
        
        findAccountButtonView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.height.equalTo(14)
            $0.width.equalTo(66)
        }
        
        findAccountLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(14)
            $0.width.equalTo(52)
        }
        
        moreImageView.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.size.equalTo(12)
        }
    }
    
    override func setDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func makeTextField( placeholder: String, isSecure: Bool = false ) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.setPlaceholderColor(.baeminGray700)
        textField.font = .body_r_14
        textField.backgroundColor = .baeminWhite
        textField.addLeftPadding(10)
        textField.autocapitalizationType = .none
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.baeminGray200.cgColor
        textField.textColor = .baeminBlack
        textField.isSecureTextEntry = isSecure
        textField.clearButtonMode = isSecure ? .never : .whileEditing
        textField.addTarget(self, action: #selector(updateLoginButtonState), for: .allEditingEvents)
        return textField
    }
    
    private func pushToWelcome() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.email = emailTextField.text
        navigationController?.pushViewController(welcomeVC, animated: true)
        welcomeVC.loginDataCompletion = { [weak self] in
            self?.resetTextField()
            self?.updateLoginButtonState()
            
        }
    }
    
    private func resetTextField() {
        emailTextField.text = nil
        passwordTextField.text = nil
        passwordTextField.isSecureTextEntry = true
        secureButton.setImage(passwordTextField.isSecureTextEntry ? .eyeSlash : .eye, for: .normal)
    }
    
    @objc
    private func clearButtonTapped() {
        passwordTextField.text = nil
        updateLoginButtonState()
    }
    
    @objc
    private func secureButtonTapped() {
        let isSecure = passwordTextField.isSecureTextEntry
        secureButton.setImage(isSecure ? .eye : .eyeSlash, for: .normal)
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc
    private func loginButtonDidTap() {
        guard let email = emailTextField.text, let password = passwordTextField.text, email.isValidEmail, password.isValidPassword else {
            if emailTextField.text?.isValidEmail == false {
                self.view.makeToast("이메일 형식이 달라요", duration: 1.0, position: .bottom)
            } else if passwordTextField.text?.isValidPassword == false {
                self.view.makeToast("비밀번호 형식이 달라요", duration: 1.0, position: .bottom)
            }
            return
        }
        view.endEditing(true)
        pushToWelcome()
    }
    
    @objc
    private func updateLoginButtonState() {
        let isEmailValid = (emailTextField.text?.isEmpty == false)
        let isPasswordValid = (passwordTextField.text?.isEmpty == false)
        let canLogin = isEmailValid && isPasswordValid
        
        loginButton.isEnabled = canLogin
        loginButton.backgroundColor = canLogin ? .baeminMint500 : .baeminGray200
        
        if passwordTextField.text?.isEmpty == false {
            clearButton.isHidden = false
            secureButton.isHidden = false
        }
        else
        {
            clearButton.isHidden = true
            secureButton.isHidden = true
        }
    }
    
    @objc
    private func findAccountButtonDidTap() {
        print("계정 찾기 버튼 눌림")
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.baeminBlack.cgColor
        textField.layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.baeminGray200.cgColor
        textField.layer.borderWidth = 1
    }
}
