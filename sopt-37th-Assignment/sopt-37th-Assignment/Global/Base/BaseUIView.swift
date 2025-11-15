//
//  BaseUIView.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/29/25.
//

import UIKit

class BaseUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {}
    
    func setLayout() {}
}
