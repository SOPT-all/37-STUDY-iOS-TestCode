//
//  BaeminButton.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/23/25.
//

import UIKit

enum BaeminButtonStyle {
    case smallNormal
    case smallSelected
    case LongNormal
    case LongSelected
    
    var backgroundColor: UIColor {
        switch self {
        case .smallNormal, .LongNormal:
            return .baeminGray200
        case .smallSelected, .LongSelected:
            return .baeminMint500
        }
    }
    
    var radius: CGFloat {
        return 4
    }
    
    var font: UIFont {
        return FontManager.headB18.font
    }
    
    var borderColor: UIColor {
        return .clear
    }
    
    var isEnabled: Bool {
        switch self {
        case .smallNormal, .LongNormal:
            return false
        case .smallSelected, .LongSelected:
            return true
        }
    }
    
    var buttonHeight: CGFloat {
        switch self {
        case .smallNormal, .smallSelected:
            return 46
        case .LongNormal, .LongSelected:
            return 52
        }
    }
}

final class BaeminButton: UIButton {
    private let style: BaeminButtonStyle
    private let title: String
    
    init(
        style: BaeminButtonStyle,
        title: String
    ) {
        self.style = style
        self.title = title
        super.init(frame: .zero)
        
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        self.backgroundColor = style.backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(.baeminWhite, for: .normal)
        self.titleLabel?.font = style.font
        self.layer.cornerRadius = style.radius
        self.isEnabled = style.isEnabled
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(style.buttonHeight)
        }
    }
    
    func updateBaeminButtonStyle(style: BaeminButtonStyle) {
        self.do {
            $0.backgroundColor = style.backgroundColor
            $0.isEnabled = style.isEnabled
        }
    }
}
