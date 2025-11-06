//
//  FindIDBottomSheetViewController.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/25/25.
//

import UIKit

protocol findIDBottomSheetDelegate: AnyObject {
    func confirmButtonDidTap(name: String)
}

final class FindIDBottomSheetViewController: BaseViewController {
    private let rootView = FindIDBottomSheetView()
    weak var delegate: findIDBottomSheetDelegate?
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func setAddTarget() {
        rootView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        rootView.confirmButton.addTarget(self, action: #selector(confirmButtonDidTap), for: .touchUpInside)
    }
}

extension FindIDBottomSheetViewController {
    @objc
    private func textFieldDidChange() {
        if let text = rootView.textField.text {
            if !text.isEmpty {
                rootView.confirmButton.isEnabled = true
                rootView.confirmButton.updateBaeminButtonStyle(style: .smallSelected)
            }
        }
    }
    
    @objc
    private func confirmButtonDidTap() {
        if let nameText = rootView.textField.text {
            delegate?.confirmButtonDidTap(name: nameText)
            print(nameText)
        }
        self.dismiss(animated: true)
    }
}
