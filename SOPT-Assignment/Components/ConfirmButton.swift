//
//  ConfirmButton.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 10/25/25.
//

import UIKit
import SnapKit

final class ConfirmButton: UIButton {
    
    private var toggle = false
    var isAvailable: Bool { return toggle } // get-only property
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
        
    private lazy var title: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Pretendard.Bold.name(), size: 18)
        return label
    }()
    
    private func setConstraints() {
        self.addSubview(title)
        
        self.layer.cornerRadius = 4
        
        self.snp.makeConstraints { make in
            make.height.equalTo(46)
        }
        
        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(title: String, isAvailable: Bool = false) {
        self.title.text = title
        toggle = self.isAvailable
        if isAvailable {
            setAvailableMode()
        } else {
            setUnavailableMode()
        }
    }
    
    func setUnavailableMode() {
        self.backgroundColor = .baeminGray200
        toggle = false
        self.isEnabled = false
    }
    
    func setAvailableMode() {
        self.backgroundColor = .baeminMint300
        toggle = true
        self.isEnabled = true
    }
    
    func toggleMode() {
        toggle.toggle()
        if toggle {
            setAvailableMode()
        } else {
            setUnavailableMode()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
