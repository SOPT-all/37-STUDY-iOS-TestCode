//
//  WelcomeViewController.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/26/25.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - Properties

    
    var name: String?
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다"
        label.font = .size17
        return label
    }()
    
    private let welcomeNewMember: UILabel = {
        let label = UILabel()
        label.text = "반가워요"
        label.font = .size24
        label.textAlignment = .center
        return label
    }()
    
    private let baeminImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "배민 이미지")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("뒤로가기", for: .normal)
        button.titleLabel?.font = .size17
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "baemin_mint")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLayout()
    }
    
    // MARK: - Action
    
    @objc
    private func handleBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func bindID() {
        guard let name = name else { return }
        self.welcomeLabel.text = "\(name.isEmpty ? "회원" : name)님 반가워요!"
    }
    
    
}

// MARK: - UI & Layout

extension  WelcomeViewController {
    func addLayout() {
        bindID()
        view.backgroundColor = .white
        view.addSubviews(baeminImage, backButton, welcomeLabel)
        setImage()
        setBUtton()
        setLabel()
    }
    
    func setImage() {
    
        baeminImage.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 120)
        baeminImage.setDimensions(height:211 , width: UIScreen.main.bounds.width)
    }
    
    func setBUtton() {
        backButton.centerX(inView: view, topAnchor: baeminImage.bottomAnchor, paddingTop: 40)
        backButton.setDimensions(height: 46, width: 343)
    }
    
    
    func setLabel() {
        welcomeLabel.centerX(inView: view, topAnchor: backButton.bottomAnchor, paddingTop: 40)
    }
}




