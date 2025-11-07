//
//  LoginViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.21.
//

import SnapKit

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Component
    lazy var navigationBarView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var navigationBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .arrowLeft), for: .normal)
        button.addTarget(self, action: #selector(onClickNavigationBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 또는 아이디로 계속"
        label.font = .pretendard(.title_sb_18)
        return label
    }()
    
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var emailTextField: AnimatedTextField = {
        let animatedTextField = AnimatedTextField()
        
        animatedTextField.configure(placeholder: "이메일 또는 아이디를 입력해 주세요", animatedPlaceholder: "이메일 아이디")
        
        animatedTextField.textField.tintColor = .baeminMint300 // caret
        animatedTextField.textField.clearButtonMode = .whileEditing
        animatedTextField.textField.keyboardType = .emailAddress
        animatedTextField.textField.spellCheckingType = .no
        animatedTextField.textField.autocapitalizationType = .none
        animatedTextField.textField.autocorrectionType = .no
        animatedTextField.textField.inlinePredictionType = .no
        animatedTextField.textField.smartDashesType = .no
        animatedTextField.textField.smartQuotesType = .no
        animatedTextField.textField.smartInsertDeleteType = .no
        animatedTextField.textField.delegate = self
        animatedTextField.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        return animatedTextField
    }()
    
    lazy var passwordTextField: AnimatedTextField = {
        let animatedTextField = AnimatedTextField()
        
        animatedTextField.configure(placeholder: "비밀번호를 입력해 주세요", animatedPlaceholder: "비밀번호")
        animatedTextField.addSecurityButton()
        
        animatedTextField.textField.tintColor = .baeminMint300 // caret
        animatedTextField.textField.returnKeyType = .done
        animatedTextField.textField.clearButtonMode = .whileEditing
        animatedTextField.textField.spellCheckingType = .no
        animatedTextField.textField.autocapitalizationType = .none
        animatedTextField.textField.autocorrectionType = .no
        animatedTextField.textField.inlinePredictionType = .no
        animatedTextField.textField.smartDashesType = .no
        animatedTextField.textField.smartQuotesType = .no
        animatedTextField.textField.smartInsertDeleteType = .no
        animatedTextField.textField.isSecureTextEntry = true
        animatedTextField.textField.delegate = self
        animatedTextField.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        return animatedTextField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = .baeminGray200
        button.setTitleColor(.baeminWhite, for: .normal)
        button.setTitle("로그인", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .pretendard(.head_b_18)
        button.addTarget(self, action: #selector(onClickLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var findAccountButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.attributedTitle = AttributedString("계정 찾기", attributes: AttributeContainer([
            .font: UIFont.pretendard(.body_r_14)
        ]))
        configuration.image = UIImage(resource: .chevronRight)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 4
        configuration.titleAlignment = .center
        
        button.configuration = configuration
        button.tintColor = .baeminBlack
        button.addTarget(self, action: #selector(onClickFindAccountButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var findAccountLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .pretendard(.body_r_14)
        return label
    }()
    
    // MARK: - Component Action
    @objc private func onClickNavigationBackButton() {
        Log.d("Back")
    }
    
    @objc private func onClickLoginButton() {
        guard let isValidEmail = emailTextField.textField.text?.isValidEmail() else { return }
        guard let isValidPassword = passwordTextField.textField.text?.isValidPassword() else { return }
        
        if isValidEmail && isValidPassword {
            let welcomeViewController = WelcomeViewController()
            welcomeViewController.configure(id: emailTextField.textField.text, resetLoginViewController: { [weak self] in
                guard let self else { return }
                emailTextField.textField.text = nil
                passwordTextField.textField.text = nil
                emailTextField.setFocused(false)
                passwordTextField.setFocused(false)
            })
            navigationController?.pushViewController(welcomeViewController, animated: true)
        } else {
            presentInvalidAlert(isValidEmail: isValidEmail, isValidPassword: isValidPassword)
        }
    }
    
    @objc private func editingChanged() {
        let hasText: Bool = !(emailTextField.textField.text?.isEmpty ?? true) && !(passwordTextField.textField.text?.isEmpty ?? true)
        loginButton.backgroundColor = hasText ? .baeminMint500 : .baeminGray200
        loginButton.isEnabled = hasText
    }
    
    @objc private func onClickFindAccountButton() {
        let findAccountViewController = FindAccountViewController()
        findAccountViewController.modalPresentationStyle = .pageSheet
        if let sheet = findAccountViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        findAccountViewController.applyEmailToLoginViewController = { [weak self] email in
            self?.findAccountLabel.text = email
        }
        present(findAccountViewController, animated: true)
    }
    
    private func presentInvalidAlert(isValidEmail: Bool, isValidPassword: Bool) {
        let title: String
        let firstResponder: UITextField
        
        switch (isValidEmail, isValidPassword) {
        case (false, false):
            title = "이메일과 비밀번호 형식이 달라요"
            firstResponder = emailTextField.textField
        case (false, true):
            title = "이메일 형식이 달라요"
            firstResponder = emailTextField.textField
        case (true, false):
            title = "비밀번호 형식이 달라요"
            firstResponder = passwordTextField.textField
        default: return
        }
        
        let alert: UIAlertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            firstResponder.becomeFirstResponder()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Configure
    private func configureView() {
        view.backgroundColor = .baeminWhite
        
        view.addSubview(navigationBarView)
        view.addSubview(inputStackView)
        view.addSubview(loginButton)
        view.addSubview(findAccountButton)
        view.addSubview(findAccountLabel)
        
        navigationBarView.addSubview(navigationBackButton)
        navigationBarView.addSubview(navigationTitleLabel)
        
        inputStackView.addArrangedSubview(emailTextField)
        inputStackView.addArrangedSubview(passwordTextField)
        
        navigationBarView.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(42)
        })
        navigationBackButton.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        })
        navigationTitleLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        inputStackView.snp.makeConstraints({
            $0.top.equalTo(navigationBarView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })
        emailTextField.snp.makeConstraints({
            $0.height.equalTo(46)
        })
        passwordTextField.snp.makeConstraints({
            $0.height.equalTo(46)
        })
        loginButton.snp.makeConstraints({
            $0.height.equalTo(46)
            $0.top.equalTo(inputStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })
        findAccountButton.snp.makeConstraints({
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        })
        findAccountLabel.snp.makeConstraints({
            $0.top.equalTo(findAccountButton.snp.bottom).offset(38)
            $0.centerX.equalToSuperview()
        })
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if emailTextField.textField === textField {
            emailTextField.setFocused(true)
        } else if passwordTextField.textField === textField {
            passwordTextField.setFocused(true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.textField === textField {
            emailTextField.setFocused(false)
        } else if passwordTextField.textField === textField {
            passwordTextField.setFocused(false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.textField === textField {
            passwordTextField.textField.becomeFirstResponder()
        } else if passwordTextField.textField === textField {
            passwordTextField.textField.resignFirstResponder()
        }
        return true
    }
}

#Preview {
    LoginViewController()
}
