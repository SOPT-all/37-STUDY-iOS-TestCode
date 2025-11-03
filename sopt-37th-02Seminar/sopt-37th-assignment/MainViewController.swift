//
//  MainViewController.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/26/25.
//

import UIKit

protocol BottomSheetDelegate: AnyObject {
    func showNewEmail(_ email: String)
}

class MainViewController: UIViewController {

    // MARK: - Properties
    
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    private let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleResetIdTapped))

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 또는 아이디로 계속"
        label.font = .size17
        return label
    }()
    
    private var newEmailLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .size17
        return label
    }()
    
    private let emailInfoLabel: UILabel = {
        let label = CustomPaddingLabel(0, 0, 3, 3)
        label.text = "이메일 아이디"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.backgroundColor = .white
        label.isHidden = true
        return label
    }()
    
    private let passwordInfoLabel: UILabel = {
        let label = CustomPaddingLabel(0, 0, 3, 3)
        label.text = "비밀번호"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.backgroundColor = .white
        label.isHidden = true
        return label
    }()
        
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = false
        view.addSubviews(emailTextField, emailInfoLabel, cleanEmailTextFieldButton)
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 아이디"
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.tag = TextFieldStyle.email.rawValue
        textField.addHorizontalPadding()
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = false
        view.addSubviews(passwordTextField,passwordInfoLabel,cleanPasswordTextFieldButton,securityToggleButton)
        return view
    }()
     
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.tag = TextFieldStyle.password.rawValue
        textField.addHorizontalPadding()
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var securityToggleButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(named: "eyeblack"), for: .normal)
        button.addTarget(self, action: #selector(handleSecurityToggleButtonTapped), for: .touchUpInside)
        button.anchor(width: 24, height: 24)
        return button
    }()
          
    private lazy var cleanEmailTextFieldButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(cleanEmailButtonTapped), for: .touchUpInside)
        button.tintColor = UIColor(named: "baemin_gray")
        button.anchor(width: 20, height: 20)
        return button
    }()
    
    private lazy var cleanPasswordTextFieldButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(cleanPasswordButtonTapped), for: .touchUpInside)
        button.tintColor = UIColor(named: "baemin_gray")
        button.anchor(width: 20, height: 20)
        return button
    }()
    
    private lazy var LoginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews(emailTextFieldView, passwordTextFieldView, loginButton)
        stackView.spacing = 6
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .size17
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "baemin_gray")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLoginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let resetIdLabel: UILabel = {
        let label = UILabel()
        label.text = "계정찾기"
        label.textColor = UIColor(named: "baemin_gray")
        return label
    }()
    
    private let resetIdImage: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "chevron.right")
        return icon
    }()
    
    private lazy var resetIdTap: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubviews(resetIdLabel, resetIdImage)
        view.axis = .horizontal
        view.spacing = 4
        view.tintColor = UIColor(named: "baemin_gray")
        return view
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLayout()
        setupTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    // MARK: - ActionMethod
    
    @objc
    private func handleResetIdTapped() {
        let viewControllerToPresent = BottomSheetViewController() //
        viewControllerToPresent.delegate = self
            if let sheet = viewControllerToPresent.sheetPresentationController {
                if #available(iOS 16.0, *) {
                      sheet.detents = [
                          .custom { _ in 400 }
                      ]
                }else {
                    sheet.detents = [.medium()]
                }
                
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 16
                sheet.largestUndimmedDetentIdentifier = nil
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false // 스크롤로 시트 확장 방지
                sheet.prefersEdgeAttachedInCompactHeight = true
                // 화면 세로가 짧은경우 화면 가장자리에 붙음
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true // 가로폭 자동 조절
            }
            
            present(viewControllerToPresent, animated: true)
    }
    
    @objc
    private func handleLoginButtonTapped() {
        
        let isEmailValid = isValidEmail(emailTextField.text)
        let isPasswordValid = isValidPassword(passwordTextField.text)
        
        if !isEmailValid {
            if !isPasswordValid {
                checkIsFormValid(message: "이메일과 비밀번호를 다시 입력하세요", title: "로그인 형식이 잘못되었습니다")
                return
            }
        }
        
        if !isEmailValid {
            checkIsFormValid(message: "이메일을 다시 입력하세요", title: "이메일 형식이 달라요")
            return
        }
        
        if !isPasswordValid {
            checkIsFormValid(message: "비밀번호를 다시 입력하세요", title: "비밀번호 형식이 달라요")
            return
        }
        
        
        pushToWelcomeVC()
    }
    
    
    @objc
    private func handleSecurityToggleButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eyeblack" : "eye"
        securityToggleButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @objc
    private func cleanEmailButtonTapped() {
        emailTextField.text = ""
    }
    
    @objc
    private func cleanPasswordButtonTapped() {
        passwordTextField.text = ""
    }
    
    
    //MARK: Method
    
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.name = emailTextField.text
        welcomeViewController.navigationItem.title = "대체 뼈찜 누가 시켰어"
        view.endEditing(true)
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    
    private func updateLoginButtonState(isEnabled: Bool, backgroundColor: UIColor?) {
        loginButton.isEnabled = isEnabled
        loginButton.backgroundColor = backgroundColor
    }
    
    private func isValidEmail(_ string: String?) -> Bool {
        guard let string = string else { return false }
        
        return string.range(of: self.emailRegex, options: .regularExpression) != nil
    }
    
    private func isValidPassword(_ string: String?) -> Bool {
        guard let string = string else { return false }
        
        return string.range(of: self.passwordRegex, options: .regularExpression) != nil
    }
    
    private func checkIsFormValid(message: String, title: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "확인", style: .default) { _ in
        }
        alertController.addAction(yesAction)
        present(alertController, animated: true)
        return
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleResetIdTapped))
        resetIdTap.addGestureRecognizer(tapGesture)
    }
    
}


// MARK: - textFieldDelegate

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(named: "baemin_black")?.cgColor
        textField.layer.borderWidth = 2
        
        if textField == emailTextField {
            cleanEmailTextFieldButton.isHidden = false
            emailTextField.placeholder = "이메일 또는 아이디를 입력해주세요"
            emailInfoLabel.isHidden = false
        }
        if textField == passwordTextField {
            cleanPasswordTextFieldButton.isHidden = false
            securityToggleButton.isHidden = false
            passwordTextField.placeholder = "비밀번호를 입력해주세요"
            passwordInfoLabel.isHidden = false
        }
    
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "baemin_gray")?.cgColor
        textField.layer.borderWidth = 1
        textField.placeholderFallback()
        if textField == emailTextField {
            cleanEmailTextFieldButton.isHidden = true
            emailInfoLabel.isHidden = true
        }
        if textField == passwordTextField {
            cleanPasswordTextFieldButton.isHidden = true
            securityToggleButton.isHidden = true
            passwordInfoLabel.isHidden = true
        }
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let isEmpty = (emailTextField.text?.isEmpty ?? true ) || (passwordTextField.text?.isEmpty ?? true)
        if !isEmpty {
            updateLoginButtonState(isEnabled: true, backgroundColor: UIColor(named: "baemin_mint"))
        } else {
            updateLoginButtonState(isEnabled: false, backgroundColor: UIColor(named: "baemin_gray"))
        }
        
    }
    

    
    // 엔터를 누르면 키보드 숨기는 코드

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
            if emailTextField.text != "", passwordTextField.text != "" {
               passwordTextField.resignFirstResponder()
                return true
            // 두번째 텍스트필드로 넘어가도록
            } else if emailTextField.text != "" {
                passwordTextField.becomeFirstResponder()
                return true
            }
            return false

        }
    
    //화면을 터치했을 때 키보드를 안보이게 하는 코드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
   
}


// MARK: - UI & Layout

extension MainViewController {
    
    func addLayout() {
        view.backgroundColor = .white
        view.addSubviews(titleLabel, LoginStackView, resetIdTap, newEmailLabel, resetIdTap)
        setLabel()
        setStackView()
        setButton()
    }
    
    func setLabel() {
        titleLabel.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 60)
        titleLabel.anchor(height: 42)
        newEmailLabel.centerX(inView: view, topAnchor: resetIdTap.bottomAnchor, paddingTop: 55)
        emailInfoLabel.anchor(leading: emailTextFieldView.leadingAnchor, bottom: emailTextFieldView.bottomAnchor, leadingPadding: 15, paddingBottom: 38)
        passwordInfoLabel.anchor(leading: passwordTextFieldView.leadingAnchor, bottom: passwordTextFieldView.bottomAnchor, leadingPadding: 15, paddingBottom: 38)
    }
    
    func setStackView() {
        LoginStackView.centerX(inView: view, topAnchor: titleLabel.bottomAnchor, paddingTop: 30)
        LoginStackView.anchor(width: 343, height: 46 * 3 + 30)
        emailTextField.anchor(top: emailTextFieldView.topAnchor, leading: emailTextFieldView.leadingAnchor, bottom: emailTextFieldView.bottomAnchor, trailing: emailTextFieldView.trailingAnchor, paddingTop: 5, paddingBottom: 5)
        passwordTextField.anchor(top: passwordTextFieldView.topAnchor, leading: passwordTextFieldView.leadingAnchor, bottom: passwordTextFieldView.bottomAnchor, trailing: passwordTextFieldView.trailingAnchor, paddingTop: 5, paddingBottom: 5)
    }
    
    func setButton() {
        securityToggleButton.anchor(trailing: passwordTextField.trailingAnchor, trailingPadding: 20)
        securityToggleButton.centerY(inView: passwordTextFieldView)
        cleanEmailTextFieldButton.centerY(inView: emailTextField)
        cleanPasswordTextFieldButton.centerY(inView: passwordTextField)
        cleanEmailTextFieldButton.anchor(trailing: emailTextField.trailingAnchor, trailingPadding: 20)
        cleanPasswordTextFieldButton.anchor(trailing: securityToggleButton.leadingAnchor, trailingPadding: 10)
        resetIdTap.centerX(inView: view, topAnchor: loginButton.bottomAnchor, paddingTop: 50)
    }
}


extension MainViewController: BottomSheetDelegate {
    func showNewEmail(_ email: String) {
        newEmailLabel.text = email
    }
}
