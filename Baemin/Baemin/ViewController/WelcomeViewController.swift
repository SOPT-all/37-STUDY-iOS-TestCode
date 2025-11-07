//
//  WelcomeViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.26.
//

import SnapKit

import UIKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - Variable
    private var id: String?
    private var resetLoginViewController: (() -> Void)?
    
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
        label.text = "대체 뼈짐 누가 시켰어??"
        label.font = .pretendard(.title_sb_18)
        return label
    }()
    
    lazy var welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .welcome)
        return imageView
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var mainWelcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다"
        label.font = .pretendard(.head_b_24)
        return label
    }()
    
    lazy var subWelcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(id ?? "")님 반가워요!"
        label.font = .pretendard(.title_sb_18)
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .baeminMint500
        button.setTitleColor(.baeminWhite, for: .normal)
        button.setTitle("뒤로가기", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .pretendard(.head_b_18)
        button.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Component Action
    @objc private func onClickNavigationBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func onClickBackButton() {
        resetLoginViewController?()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Configure
    func configure(id: String?, resetLoginViewController: (() -> Void)?) {
        self.id = id
        subWelcomeLabel.text = "\(id ?? "")님 반가워요!"
        self.resetLoginViewController = resetLoginViewController
    }
    
    private func configureView() {
        view.backgroundColor = .baeminWhite
        
        view.addSubview(navigationBarView)
        view.addSubview(welcomeImageView)
        view.addSubview(labelStackView)
        view.addSubview(backButton)
        
        navigationBarView.addSubview(navigationBackButton)
        navigationBarView.addSubview(navigationTitleLabel)
        
        labelStackView.addArrangedSubview(mainWelcomeLabel)
        labelStackView.addArrangedSubview(subWelcomeLabel)
        
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
        welcomeImageView.snp.makeConstraints({
            $0.top.equalTo(navigationBarView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(211)
        })
        labelStackView.snp.makeConstraints({
            $0.top.equalTo(welcomeImageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        })
        backButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().inset(48)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        })
    }
}

#Preview {
    WelcomeViewController()
}
