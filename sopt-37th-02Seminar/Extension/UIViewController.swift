//
//  UIViewController.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 10/29/25.
//

import Foundation
import UIKit

extension UIViewController {
    func presentDynamicBottomSheet(vc: UIViewController) {
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in
                        return vc.preferredContentSize.height
                    }
                ]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 16
            } else {
                sheet.detents = [.medium(), .large()]
            }
        }
        self.present(nav, animated: true)
    }
}
