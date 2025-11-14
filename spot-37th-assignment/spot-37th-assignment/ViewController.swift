//
//  ViewController.swift
//  spot-37th-assignment
//
//  Created by 어재선 on 10/30/25.
//

import UIKit
import SnapKit
import Then

final class ViewController: UIViewController {

    private lazy var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setStyle()
        setLayout()
        
    }
    
}

extension ViewController {
    
    func setStyle() {
        loginButton.do {
            $0.setTitle("로그인하기", for: .normal)
            $0.setTitleColor(.baeminWhite, for: .normal)
            $0.backgroundColor = .baeminMint500
            $0.titleLabel?.font = .head_b_24
            $0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
            $0.layer.cornerRadius = 4
        }
    }
    func setHierarchy() {
        self.view.addSubview(loginButton)
    }
    
    func setLayout() {
        self.view.backgroundColor = .baeminWhite
        
        self.loginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(343)
            $0.height.equalTo(46)
            
        }
        
    }
    
    @objc func loginButtonDidTap() {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
}

