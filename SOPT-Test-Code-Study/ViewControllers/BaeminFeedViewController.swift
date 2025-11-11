//
//  BaeminFeedViewController.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/5/25.
//

import UIKit
import SnapKit
import Then

final class BaeminFeedViewController: UIViewController {
    
    var selectedTapIndex: Int = 0
    var isInitialLayoutDone = false
    
    private lazy var baeminFeedView = BaeminFeedView().then {
        $0.rankCollectionView.delegate = self
        $0.rankCollectionView.dataSource = self
        $0.bannerCollectionView.delegate = self
        $0.bannerCollectionView.dataSource = self
        $0.categoryCollectionView.delegate = self
        $0.categoryCollectionView.dataSource = self
        $0.marketCollectionView.delegate = self
        $0.marketCollectionView.dataSource = self
        $0.tapViewCollectionView.delegate = self
        $0.tapViewCollectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        self.view = baeminFeedView
        registerCells()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard !isInitialLayoutDone else { return }
        isInitialLayoutDone = true
        
        let initialIndexPath = IndexPath(item: 0, section: 0)
        let selectedTapRect: TapRect = baeminFeedView.tapViewCollectionView.fetchCellRectFor(indexPath: initialIndexPath, paddingFromLeading: 10, cellHorizontalPadding: 20)
        
        baeminFeedView.tapViewCollectionView.moveUnderlineFor(at: selectedTapRect)
        
        self.collectionView(baeminFeedView.tapViewCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        if let startCell = baeminFeedView.tapViewCollectionView.cellForItem(at: initialIndexPath) as? TapCell {
            startCell.selected()
        }
    }
    
    private func registerCells() {
        baeminFeedView.rankCollectionView.register(RankCell.self, forCellWithReuseIdentifier: RankCell.identifier())
        baeminFeedView.bannerCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier())
        baeminFeedView.categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier())
        baeminFeedView.marketCollectionView.register(PebbleCell.self, forCellWithReuseIdentifier: PebbleCell.identifier())
        baeminFeedView.tapViewCollectionView.register(TapCell.self, forCellWithReuseIdentifier: TapCell.identifier())
    }
    
}

extension BaeminFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case baeminFeedView.tapViewCollectionView:
            return CategoryData.data.count
        case baeminFeedView.categoryCollectionView:
            return CategoryData.data.count
        case baeminFeedView.marketCollectionView:
            return MarketData.data.count
        case baeminFeedView.bannerCollectionView:
            return BannerData.data.count
        case baeminFeedView.rankCollectionView:
            return RankData.data.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collection = collectionView as? BaeminUICollectionView else {
            if collectionView == baeminFeedView.tapViewCollectionView {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TapCell.identifier(), for: indexPath) as? TapCell else {
                return UICollectionViewCell()
                }
                cell.configure(CategoryData.data[indexPath.row].name)
                return cell
            }
            return UICollectionViewCell()
        }
        switch collection.type {
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankCell.identifier(), for: indexPath) as? RankCell else {
            return UICollectionViewCell()
            }
            cell.configure(RankData.data[indexPath.row])
            return cell
        case .banner:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier(), for: indexPath) as? BannerCell else {
            return UICollectionViewCell()
            }
            cell.configure(BannerData.data[indexPath.row])
            return cell
        case .market:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PebbleCell.identifier(), for: indexPath) as? PebbleCell else {
            return UICollectionViewCell()
            }
            cell.configure(MarketData.data[indexPath.row])
            return cell
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier(), for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
            }
            cell.configure(data:  CategoryData.data[indexPath.row].cells, destination: CategoryData.data[indexPath.row].name, delegate: self, dataSource: self)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

extension BaeminFeedViewController: UICollectionViewDelegateFlowLayout {
    
    // Cell 크기 정의
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == baeminFeedView.tapViewCollectionView {
            let categoryName = CategoryData.data[indexPath.item].name
            
            let label = UILabel().then {
                $0.font = UIFont(name: Pretendard.Bold.name(), size: 18)
                $0.text = categoryName
                $0.sizeToFit()
            }
            
            let cellWidth = label.frame.width + 20 // cell간 간격 20
            let cellHeight: CGFloat = 48
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        guard let collection = collectionView as? BaeminUICollectionView else { return .zero }
        
        switch collection.type {
        case .rank :
            let width: CGFloat = 145
            let height: CGFloat = 250
            return CGSize(width: width, height: height)
        case .banner :
            let width: CGFloat = collectionView.frame.self.size.width
            let height: CGFloat = 180
            return CGSize(width: width, height: height)
        case .market, .categoryCell :
            return CGSize(width: 58, height: 74)
        case .category :
            let width: CGFloat = collectionView.frame.self.size.width
            let height: CGFloat = 235
            return CGSize(width: width, height: height)
        default:
            return .zero
        }
    }
    
    // 행간
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let collection = collectionView as? BaeminUICollectionView else { return 0}
        
        switch collection.type {
        case .rank :
            return 16
        case .market :
            return 9
        default:
            return 0
        }
    }
    
    // mergin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let collection = collectionView as? BaeminUICollectionView else { return .zero }
        
        switch collection.type {
        case .rank :
            return .init(top: 0, left: 20, bottom: 0, right: 20)
        case .market :
            return .init(top: 11, left: 16, bottom: 11, right: 16)
        default :
            return .zero
        }
    }
    
    // cell 선택에 대한 대응
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.baeminFeedView.tapViewCollectionView {
            updateTapSelection(to: indexPath)
            self.baeminFeedView.categoryCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    // 사용자가 직접 스크롤(스와이프)해서 멈췄을 때 호출됨
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == baeminFeedView.categoryCollectionView {
            // 현재 스크롤 위치를 기준으로 페이지 인덱스 계산
            let newIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            updateTapSelection(to: IndexPath(row: newIndex, section: 0))
        }
    }
    
    // 탭 클릭 등으로 인해 프로그래밍 방식의 스크롤이 멈췄을 때 호출됨
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == baeminFeedView.categoryCollectionView {
            // 현재 스크롤 위치를 기준으로 페이지 인덱스 계산
            let newIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            updateTapSelection(to: IndexPath(row: newIndex, section: 0))
        }
    }
    
    // IndexPath를 이용해, Tab의 Underline을 이동 + Label textColor 변화
    private func updateTapSelection(to newIndexPath: IndexPath) {
        // gaurd문 위에 있는 이유, 아래에 있으면 Underline이 생성되지 않는다.
        let selectedTapRect: TapRect = baeminFeedView.tapViewCollectionView.fetchCellRectFor(indexPath: newIndexPath, paddingFromLeading: 10, cellHorizontalPadding: 20)
        baeminFeedView.tapViewCollectionView.moveUnderlineFor(at: selectedTapRect)
        
        guard newIndexPath.item != selectedTapIndex else { return } // 중복 호출 방지!!
        
        let oldIndexPath = IndexPath(item: selectedTapIndex, section: 0)
        selectedTapIndex = newIndexPath.item
        
        if let selectedCell = baeminFeedView.tapViewCollectionView.cellForItem(at: newIndexPath) as? TapCell {
            selectedCell.selected()
        }
        if let pastCell = baeminFeedView.tapViewCollectionView.cellForItem(at: oldIndexPath) as? TapCell {
            pastCell.deselected()
        }
    }
    
}

#Preview {
    BaeminFeedViewController()
}
