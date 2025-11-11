//
//  BaeminUICollectionView.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/7/25.
//

import UIKit


final class BaeminUICollectionView: UICollectionView {
    var type: CollectionType?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setType(_ type: CollectionType) {
        self.type = type
    }
}
