//
//  CustomNavigationBar.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/25/25.
//

import UIKit
import SnapKit
import Then

class CustomNavigationBar: UIView {
    
    var delegate: UIViewController?
    
    private lazy var backButton = UIButton().then {
        $0.setImage(.leftPointer, for: .normal)
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = UIFont(name: Pretendard.Bold.name(), size: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    func configure(title: String,
                   isLeftButtonShown: Bool = false,
                   delegate: UIViewController) {
        titleLabel.text = title
        backButton.isHidden = isLeftButtonShown
        self.delegate = delegate
    }
    
    func setConstraints() {
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(42).priority(.high)
        }
        
        backButton.imageView?.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func backButtonTapped() {
        guard let delegate = delegate else { return }
        if delegate.navigationController != nil {
            print("pop")
            delegate.navigationController?.popViewController(animated: true)
        } else {
            print("dismiss")
            delegate.dismiss(animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview {
    LoginViewController()
}
