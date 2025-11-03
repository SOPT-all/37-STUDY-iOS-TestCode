//
//  BaseUIViewController.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/29/25.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .baeminWhite
        
        setUI()
        setLayout()
        addTarget()
        setDelegate()
        
        hideKeyboardWhenTappedAround()
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Custom Method
    
    func setUI() {}
    
    func setLayout() {}
    
    // MARK: - Action Method
    
    func addTarget() {}
    
    // MARK: - delegate Method
    
    func setDelegate() {}
}
