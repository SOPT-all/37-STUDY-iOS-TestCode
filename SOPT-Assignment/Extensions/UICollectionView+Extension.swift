//
//  UICollectionView.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/7/25.
//

import UIKit

extension UICollectionView {
    func fetchCellRectFor(indexPath index: IndexPath,
        paddingFromLeading: CGFloat, cellHorizontalPadding: CGFloat) -> TapRect {
        // 1)
        guard let cellAttributes = self.layoutAttributesForItem(at: index)
            else { return TapRect(index: 0, width: 0, xPosition: CGPoint()) }
        // 2)
        let cellOrigin = cellAttributes.frame.origin
        // 3)
        let cellXPosition: CGPoint = CGPoint(
            x: cellOrigin.x + paddingFromLeading,
            y: cellOrigin.y)
        // 4)
        let cellWidth: CGFloat = cellAttributes.size.width - cellHorizontalPadding
        
        return TapRect(index: index.item, width: cellWidth, xPosition: cellXPosition)
    }
}
