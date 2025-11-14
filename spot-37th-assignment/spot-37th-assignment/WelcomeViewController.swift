//
//  WelcomeViewController.swift
//  spot-37th-assignment
//
//  Created by 어재선 on 10/31/25.
//

import UIKit
import SnapKit
import Then



final class WelcomeViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let backButton = UIButton()
    
    private var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStyle()
        self.setHierarchy()
        self.setlayout()
        self.bindEmail()
    }
}

// MARK: - UI
extension WelcomeViewController {
    func setStyle() {
        self.view.backgroundColor = .baeminWhite
        self.navigationItem.title = "대체 뼈짐 누가 시켰어"
        
        self.imageView.do {
            $0.image = UIImage(named: "baemin-image1")
            $0.sizeToFit()
        }
        
        self.titleLabel.do {
            $0.text = "환영합니다."
            $0.font = .head_b_24
            $0.textColor = .baeminBlack
            $0.textAlignment = .center
        }
        
        self.subTitleLabel.do {
            $0.text = "OO님 반가워요!"
            $0.font = .head_b_18
            $0.textColor = .baeminBlack
            $0.textAlignment = .center
            
        }
        
        self.backButton.do {
            $0.setTitle("뒤로가기", for: .normal)
            $0.setTitleColor(.baeminWhite, for: .normal)
            $0.backgroundColor = .baeminMint500
            $0.titleLabel?.font = .head_b_18
            $0.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
            $0.layer.cornerRadius = 4
        }
        
    }
    
    func setHierarchy() {
        [self.imageView, self.titleLabel, self.subTitleLabel,self.backButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    func setlayout() {
        
        self.imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(101)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(211)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(46)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(52)
        }
    }
    
    @objc func backButtonDidTap() {
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func bindEmail() {
        guard let nameText = name else { return }
        self.subTitleLabel.text = "\(nameText)님 반가워요!"
    }
    
    func setLabelText(name: String?) {
        self.name = name
    }
}
