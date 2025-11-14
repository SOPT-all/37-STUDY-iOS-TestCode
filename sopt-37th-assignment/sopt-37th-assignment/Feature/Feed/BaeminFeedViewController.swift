//
//  MainViewController.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 11/5/25.
//

import UIKit

final class BaeminFeedViewController: BaseViewController {
    private let rootView = BaeminFeedView()
    
    override func loadView() {
        view = rootView
    }
    
    override func setAddTarget() {
        rootView.segementView.segmentedControl.addTarget(self, action: #selector(segmentDidTap(_:)), for: .valueChanged)
    }
}

extension BaeminFeedViewController {
    @objc
    private func segmentDidTap(_ sender: UISegmentedControl) {
        print("segmentDidTap")
    }
}
