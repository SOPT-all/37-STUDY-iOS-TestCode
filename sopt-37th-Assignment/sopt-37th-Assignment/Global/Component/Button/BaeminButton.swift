//
//  MidiumBaeminButton.swift
//  sopt-37th-Assignment
//
//  Created by 김나연 on 10/29/25.
//

import UIKit

import SnapKit

public final class BaeminButton: UIButton, AppButtonProtocol {
    
    public enum BaeminButtonSize: CGFloat {
        case medium = 46
        case large = 52
    }
    
    private var heightConstraint: Constraint?
    
    public var size: BaeminButtonSize = .medium {
        didSet {
            heightConstraint?.update(offset: size.rawValue)
        }
    }
        
    public var cornerRadius: CGFloat = 4 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    public var isDisabled: Bool = false {
        didSet {
            isUserInteractionEnabled = !isDisabled
            setUI()
        }
    }
    
    public var text: String? {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    
    // MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        setTitleColor(.baeminWhite, for: .normal)
        titleLabel?.font = .head_b_18
        setTitle(text, for: .normal)
        setUI()
        setLayout()
    }
    
    
    // MARK: - SetUI
    
    private func setUI() {
        backgroundColor = isDisabled ? .baeminGray200 : .baeminMint500
    }
    
    
    // MARK: - SetLayout
    
    private func setLayout() {
        self.snp.makeConstraints {
            heightConstraint = $0.height.equalTo(size.rawValue).constraint
        }
    }
}
