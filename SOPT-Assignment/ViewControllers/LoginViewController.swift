//
//  LoginViewController.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/25/25.
//

import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController, WelcomeViewControllerDelegate {
    
    private lazy var customNavigationBar = CustomNavigationBar().then {
        $0.configure(title: "이메일 또는 아이디로 계속", delegate: self)
    }
    
    private lazy var loginButton = ConfirmButton().then {
        $0.configure(title: "로그인")
        $0.addTarget(self, action: #selector(pushWelcomeViewController), for: .touchUpInside)
    }
    
    private lazy var emailIdTextField = designedTextField().then {
        $0.placeholder = "이메일 아이디"
    }
    
    private lazy var passwordTextField = designedTextField().then {
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
    }
    
    private lazy var clearPasswordButton = UIButton().then {
        $0.setImage(.crossGray, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
    }
    
    private lazy var toggleHidePasswordButton = UIButton().then {
        $0.setImage(.eye, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(toggleHidePasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var findAccountButton = UIButton().then {
        $0.setTitle("계정 찾기 >", for: .normal)
        $0.setTitleColor(.baeminBlack, for: .normal)
        $0.titleLabel?.font = UIFont(name: Pretendard.Regular.name(), size: 14)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func didTapGoBackButton() {
        emailIdTextField.text = ""
        passwordTextField.text = ""
    }
    
    @objc func clearTextField() {
        passwordTextField.text = ""
        loginButton.setUnavailableMode()
    }
    
    @objc func toggleHidePasswordButtonTapped() {
        self.passwordTextField.isSecureTextEntry.toggle()
        self.toggleHidePasswordButton.setImage(self.passwordTextField.isSecureTextEntry ? .eye : .eyeSlash , for: .normal)
    }
    
    @objc func pushWelcomeViewController() {
        let vc = WelcomeViewController()
        vc.configure(email: emailIdTextField.text!, delegate: self)
        // 강제 언래핑 : 버튼은 TextField.text가 반드시 채워져야지만 활성화되기 때문에 사용했다.
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setEdittingMode()
        if textField == self.passwordTextField {
            clearPasswordButton.isHidden = false
            toggleHidePasswordButton.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setEdittingEndMode()
        if textField == self.passwordTextField {
            clearPasswordButton.isHidden = true
            toggleHidePasswordButton.isHidden = true
        }
    }
    
    // 입력, 삭제할 때마다 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // textField.text (편집 이전의 Text)
        // string : 추가된 텍스트 (긴 글을 붙여넣을 수 있으므로 String)
        
        // NSRange: TextField가 모두 지워질 때의 값 알아보기
        // location = 0, length = textField.text.count
        
        // " " 공백 입력 무시
        if string == " " {
            // 추후에 경고를 띄울 수도 있다.
            return false
        }
        
        checkLoginButtonValid(textField, range: range, replacementString: string)
        return true
    }
    
    // 버튼의 활성화 여부를 결정
    func checkLoginButtonValid(_ textField: UITextField, range: NSRange, replacementString string: String) {
        
        print("\(textField.text) \(string) \(range)")
        if !string.isEmpty // 추가된 것에 대한 동작
            && ((textField == emailIdTextField && passwordTextField.text?.isEmpty == false)
            || (textField == passwordTextField && emailIdTextField.text?.isEmpty == false))
        {
            loginButton.setAvailableMode()
        }
        else if
            string.isEmpty // 삭저된 것에 대한 동작 -> 해당 TextField의 값이 모두 지워진 것인지 조사
            && range.location == 0
            && range.length == textField.text?.count
        {
            loginButton.setUnavailableMode()
        }
    }
}

// MARK: - UI
extension LoginViewController {
    
    private func configureUI() {
        [customNavigationBar, emailIdTextField, passwordTextField,
         clearPasswordButton, loginButton, toggleHidePasswordButton,
         findAccountButton].forEach {
            view.addSubview($0)
        }
        
        [emailIdTextField, passwordTextField, loginButton].forEach {
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
            }
        }
        
        customNavigationBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        emailIdTextField.snp.makeConstraints { make in
            make.top.equalTo(customNavigationBar.snp.bottom).offset(24)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailIdTextField.snp.bottom).offset(12)
        }
        
        clearPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.width.height.equalTo(30)
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-56)
        }
        
        toggleHidePasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.width.height.equalTo(22)
            make.trailing.equalTo(passwordTextField.snp.trailing).offset(-20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
        
        findAccountButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(32)
        }
    }
    
    private func designedTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 4
        textField.font = UIFont(name: Pretendard.Regular.name(), size: 14)
        textField.tintColor = .baeminMint300
        
        textField.delegate = self
        
        textField.addPadding()
        textField.snp.makeConstraints { make in
            make.height.equalTo(46)
        }
        
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }
    
}

#Preview {
    UINavigationController(rootViewController: LoginViewController())
}
