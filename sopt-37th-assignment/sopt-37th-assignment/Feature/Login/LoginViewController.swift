//
//  LoginViewController.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/23/25.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    private let rootView = LoginView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        setAddTarget()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rootView.idTextField.resetStyle()
        rootView.passwordTextField.resetStyle()
    }
    
    override func setAddTarget() {
        rootView.loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        rootView.idTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        rootView.passwordTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(findIDDidTap))
        rootView.findIDView.addGestureRecognizer(tapGesture)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
}

extension LoginViewController {
    @objc
    private func loginButtonDidTap() {
        if let idText = rootView.idTextField.textField.text,
            let passwordText = rootView.passwordTextField.textField.text {
            if idText.isValidEmail && passwordText.isValidPassword {
                let viewController = WelcomeViewController()
                viewController.name = idText
                self.navigationController?.pushViewController(viewController, animated: true)
            } else {
                if !idText.isValidEmail && !passwordText.isValidPassword {
                    showAlert(type: "이메일, 비밀번호")
                }
                else if !passwordText.isValidPassword {
                    showAlert(type: "비밀번호")
                }
                else {
                    showAlert(type: "이메일")
                }
            }
        }
    }
    
    @objc
    private func textFieldDidChange() {
        if let idText = rootView.idTextField.textField.text,
            let passwordText = rootView.passwordTextField.textField.text {
            rootView.loginButton.isEnabled = !idText.isEmpty && !passwordText.isEmpty
            rootView.loginButton.updateBaeminButtonStyle(style: rootView.loginButton.isEnabled ? .smallSelected : .smallNormal)
        }
    }
    
    @objc
    private func findIDDidTap() {
        guard let idText = rootView.idTextField.textField.text else { return }
        if idText.isEmpty { return }
        
        let bottomSheetViewController = FindIDBottomSheetViewController()
        if let sheet = bottomSheetViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        bottomSheetViewController.delegate = self
        present(bottomSheetViewController, animated: true)
    }
    
    private func showAlert(type: String) {
        let alert = UIAlertController(title: "\(type) 형식이 달라요", message: "형식에 맞춰 다시 작성해주세요", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
}


extension LoginViewController: findIDBottomSheetDelegate {
    func confirmButtonDidTap(name: String) {
        rootView.nameLabel.text = name
    }
}
