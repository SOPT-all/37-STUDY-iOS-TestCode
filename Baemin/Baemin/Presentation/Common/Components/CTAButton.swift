//
//  CTAButton.swift
//  Baemin
//
//  Created by 진소은 on 10/26/25.
//

import Foundation
import UIKit

enum CTAButtonStyle {
    case active
    case inactive
}

final class CTAButton: UIButton {
    
    // MARK: - Properties

    private var style: CTAButtonStyle = .inactive
    
    // MARK: - Life Cycle
    
    init() {
        super.init(frame: .zero)        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    override var isEnabled: Bool {
        willSet {
            backgroundColor = newValue ? .baeminMint500 : .baeminGray200
        }
    }
        
    private func setUI() {
        titleLabel?.font = .pretendard(.head_b_18)
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    // MARK: - Public Methods
    
    public func configure(style: CTAButtonStyle, title: String) {
        self.style = style
        setTitle(title, for: .normal)
        if style == .active {
            isEnabled = true
        } else {
            isEnabled = false
        }
    }
}
