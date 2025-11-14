//
//  MainView.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 11/5/25.
//

import UIKit

final class BaeminFeedView: BaseView {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let navigationBar = BaeminFeedNavigationBar()
    private let searchBar = BaeminSearchBar()
    private let stickySearchBar = BaeminSearchBar()
    
    private let saleView = UIView()
    private let baeminIcon = UIImageView()
    private let saleLabel = UILabel()
    private let moreButton = UIButton()
    private let gradationView = BaeminGradientView(startColor: .backgroundWhite, endColor: .gradientMint)
    
    private(set) var segementView = BaeminFeedSegementedControl()
    
    override func setUI() {
        addSubviews(scrollView, stickySearchBar)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(navigationBar, searchBar, gradationView, saleView, segementView)
        saleView.addSubviews(baeminIcon, saleLabel, moreButton)
    }
    
    override func setStyle() {
        backgroundColor = .backgroundWhite
        scrollView.delegate = self
         
        baeminIcon.do {
            $0.image = .bmart
            $0.contentMode = .scaleAspectFill
        }
        
        stickySearchBar.do {
            $0.isHidden = true
        }
        
        saleLabel.do {
            $0.text = "전상품 쿠폰팩 + 60%특가"
            $0.textColor = .baeminBlack
            $0.font = FontManager.headB16.font
        }
        
        moreButton.do {
            $0.setImage(.chevronRight, for: .normal)
        }
    }
    
    override func setLayout() {
        stickySearchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(46)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.height.greaterThanOrEqualToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(54)
            $0.leading.trailing.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        saleView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(16)
        }
        
        baeminIcon.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        saleLabel.snp.makeConstraints {
            $0.top.equalTo(baeminIcon.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(saleLabel.snp.top).inset(4)
            $0.leading.equalTo(saleLabel.snp.trailing).offset(2)
            $0.width.height.equalTo(12)
        }
        
        gradationView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(65)
        }
        
        segementView.snp.makeConstraints {
            $0.top.equalTo(saleLabel.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension BaeminFeedView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let shouldShowSticky = yOffset >= stickySearchBar.frame.origin.y + 45
        stickySearchBar.isHidden = !shouldShowSticky
    }
}
