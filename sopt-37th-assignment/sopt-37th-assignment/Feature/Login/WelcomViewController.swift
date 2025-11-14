//
//  WelcomViewController.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/25/25.
//

import UIKit

final class WelcomeViewController: BaseViewController {
    private let rootView = WelcomeView()
    
    var name: String?
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = name {
            rootView.bindName(name: name)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func setAddTarget() {
        rootView.navigationBar.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        rootView.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    override func setDelegate() {
        rootView.navigationBar.delegate = self
    }
}

extension WelcomeViewController: BaeminNavigationBarDelegate {
    @objc
    func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
