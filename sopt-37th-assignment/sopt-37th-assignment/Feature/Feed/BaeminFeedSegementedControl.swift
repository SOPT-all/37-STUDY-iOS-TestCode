//
//  BaeminFeedSegementedControl.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 11/5/25.
//

import UIKit

final class BaeminFeedSegementedControl: BaseView {
    private(set) var segmentedControl = UISegmentedControl()
    private let underlineBar = UIView()
    private let menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUI() {
        addSubviews(segmentedControl, underlineBar)
    }
    
    override func setStyle() {
        backgroundColor = .white
        
        segmentedControl.do {
            $0.insertSegment(withTitle: "음식배달", at: 0, animated: true)
            $0.insertSegment(withTitle: "픽업", at: 1, animated: true)
            $0.insertSegment(withTitle: "장보기·쇼핑", at: 2, animated: true)
            $0.insertSegment(withTitle: "선물하기", at: 3, animated: true)
            $0.insertSegment(withTitle: "혜택모아보기", at: 4, animated: true)
            $0.selectedSegmentIndex = 0
            $0.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.baeminGray300,
                NSAttributedString.Key.font: FontManager.titleSb18.font], for: .normal)
            $0.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.baeminBlack,
                NSAttributedString.Key.font: FontManager.headB18.font], for: .selected)
            $0.selectedSegmentTintColor = .clear
            $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
            $0.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        }
        
        underlineBar.do {
            $0.backgroundColor = .baeminBlack
        }
    }
    
    override func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(283)
            
        }
        segmentedControl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        underlineBar.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(13)
//            $0.width.equalTo(self.bounds.size.width / CGFloat(segmentedControl.numberOfSegments))
            $0.leading.trailing.equalTo(segmentedControl)
            $0.height.equalTo(3)
        }
    }
}
