//
//  WelcomeViewController.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/27/25.
//

import UIKit
import SnapKit
import Then

protocol WelcomeViewControllerDelegate: AnyObject {
    func didTapGoBackButton()
}

class WelcomeViewController: UIViewController {
    
    private weak var delegate: WelcomeViewControllerDelegate?
    // WelcomeVC는 LoginVC의 참조 카운트를 증가시키지 않는다.
    // 0. LoginVC는 let WelcomeVC로 참조 카운트를 증가시킨다.
    // 1. welcomeVC는 메모리에서 해제된다.
    // 2. LoginVC의 메서드를 동작시킨다.
        // 강한 순환 참조가 일어나는 조건
        // 2.1. 만약, 메서드가 오래 걸리는 비동기 함수이고 강한 참조인 경우
            // Login +2 / Welcome +1
        // 2.2. 메서드의 종료 이전에 VC가 화면에서 사라진 경우
            // Login +1 / Welcome +1
        // 2.3. LoginVC와 WelcomeVC 간의 강한 순환 참조가 발생하게 된다.
            // Login <-> Welcome
    // 3. weak 이므로 LoginVC는 메모리에서 해제된다. -> welcomeVC 또한 해제된다.
            // Login +1 / Welcome +1
            // Login 0 -> deinit -> Welcome 0 -> deinit
    
    private lazy var navigationBar = CustomNavigationBar().then {
        $0.configure(title: "대체 누가 뼈짐 시켰어??", delegate: self)
    }
    
    private lazy var imaeView = UIImageView().then {
        $0.image = .welcome
    }
    
    private lazy var welcomeMainLabel = UILabel().then {
        $0.text = "환영합니다."
        $0.textAlignment = .center
        $0.font = UIFont(name: Pretendard.Bold.name(), size: 24)
    }
    
    private lazy var welcomeSubLabel = UILabel().then {
        $0.text = "반가워요"
        $0.textAlignment = .center
        $0.font = UIFont(name: Pretendard.SemiBold.name(), size: 18)
        $0.numberOfLines = 1
    }
    
    private lazy var goBackButton = ConfirmButton().then {
        $0.configure(title: "뒤로가기", isAvailable: true)
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setConstraints()
    }
    
    @objc func backButtonTapped() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(TabBarController(), animated: false)
    }
    
    func configure(email: String, delegate: WelcomeViewControllerDelegate) {
        welcomeSubLabel.text = "\(email)님 반가워요!"
        self.delegate = delegate
    }
    
    func addSubviews() {
        [navigationBar, imaeView, welcomeMainLabel, welcomeSubLabel, goBackButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        [navigationBar, imaeView, welcomeMainLabel, welcomeSubLabel].forEach {
            $0.snp.makeConstraints{ make in
                make.leading.trailing.equalToSuperview()
            }
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        imaeView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.height.equalTo(imaeView.snp.width).multipliedBy(211.0/375.0)
        }
        
        welcomeMainLabel.snp.makeConstraints { make in
            make.top.equalTo(imaeView.snp.bottom).offset(24)
        }
        
        welcomeSubLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeMainLabel.snp.bottom).offset(14)
        }
        
        goBackButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-48)
        }
    }
    
}

#Preview {
    WelcomeViewController()
}
