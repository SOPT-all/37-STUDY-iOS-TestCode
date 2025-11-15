//
//  BottomSheetViewController.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/29/25.
//

import UIKit
import SnapKit
import Then

class BottomSheetViewController: UIViewController {
    
    weak var delegate: BottomSheetDelegate?
    
    private let infoLabel = UILabel().then {
        $0.text = "이메일을 입력해주세요"
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textColor = .black
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "이메일"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.addHorizontalPadding()
    }
    
    private lazy var enterButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        $0.backgroundColor = UIColor(named: "baemin_mint")
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        addLayout()
    }
    
    @objc
    private func enterButtonTapped() {
        guard let newEmailId = emailTextField.text else { return }
        delegate?.showNewEmail(newEmailId)
        dismiss(animated: true)
    }
  
}

// MARK: - Layout

extension BottomSheetViewController {
    
    func addLayout() {
        view.addSubviews(infoLabel, emailTextField, enterButton)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(68)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(17)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(17)
            $0.width.equalTo(343)
            $0.height.equalTo(46)
        }
        
        enterButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(135)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(17)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-17)
            $0.width.equalTo(343)
            $0.height.equalTo(46)
        }
    }
    
}


#Preview {
    BottomSheetViewController()
}
