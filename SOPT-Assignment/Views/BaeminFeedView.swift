//
//  BaeminFeedView.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/5/25.
//

import UIKit
import SnapKit
import Then

class BaeminFeedView: UIView {
    
    private lazy var stickyHeader = UIView()
    
    private lazy var locationButton = UIButton().then {
        $0.setTitle("우리집", for: .normal)
        $0.setTitleColor(.baeminBlack, for: .normal)
        $0.titleLabel?.font = UIFont(name: Pretendard.Bold.name(), size: 16)
    }
    
    private lazy var cartButton = UIButton().then {
        $0.setImage(.cart, for: .normal)
    }
    
    private lazy var notificationButton = UIButton().then {
        $0.setImage(.notification, for: .normal)
    }
    
    private lazy var discountButton = UIButton().then {
        $0.setImage(.divider, for: .normal)
    }
    
    private lazy var searchTextField = UITextField().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.baeminBlack.cgColor
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 20
        $0.font = UIFont(name: Pretendard.Regular.name(), size: 14)
        $0.tintColor = .baeminMint300
        $0.backgroundColor = .white
        
        $0.addPadding()
        $0.snp.makeConstraints { make in
            make.height.equalTo(46)
        }
        
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        
        $0.placeholder = "찾아라! 맛있는 음식과 맛집"
    }
    
    private lazy var searchIcon = UIImageView().then {
        $0.image = .search
    }
    
    private lazy var feedScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var feedContentView = UIView()
    
    private let headGradientLayer = CAGradientLayer().then {
        // 참고 블로그 : https://babbab2.tistory.com/55
        $0.colors = [
            UIColor.baeminBackgroundWhite.cgColor,
            UIColor.baeminMint300.cgColor.copy(alpha: 0.5) ?? UIColor.baeminMint300.cgColor,
        ]
        // 중앙의 y 0에서 중앙의 y 1로 이동한다.
        $0.startPoint = CGPoint(x: 0.5, y: 0.0)
        $0.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        $0.locations = [0, 1.0]
    }
    
    private lazy var headGradientView = UIView().then {
        $0.layer.addSublayer(headGradientLayer)
    }
    
    private lazy var bmartImageView = UIImageView().then {
        $0.image = .bmart
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var promotionButton = UIButton().then {
        $0.setTitle("전상품 쿠폰팩 + 60%특가 >", for: .normal)
        $0.setTitleColor(.baeminBlack, for: .normal)
        $0.titleLabel?.font = UIFont(name: Pretendard.Bold.name(), size: 16)
    }
    
    lazy var tapViewCollectionView: TapCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 8
        
        let collection = TapCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.clipsToBounds = true
        collection.layer.cornerRadius = 20
        collection.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // top-left + top-right
        collection.layer.shadowColor = UIColor.baeminMint500.cgColor
        collection.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        collection.backgroundColor = .white
        return collection
    }()
    
    lazy var categoryCollectionView: BaeminUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = .init(top: 12, left: 28, bottom: 21, right: 18)
        
        let collection = BaeminUICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.type = .category
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        
        return collection
    }()
    
    lazy var marketCollectionView: BaeminUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 9
        layout.sectionInset = .init(top: 11, left: 16, bottom: 11, right: 16)
        
        let collection = BaeminUICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.type = .market
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    lazy var bannerCollectionView: BaeminUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = BaeminUICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.type = .banner
        collection.isPagingEnabled = true
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        
        return collection
    }()
    
    private let rankGradientLayer = CAGradientLayer().then {
        $0.colors = [
            UIColor.baeminBlue500.cgColor,
            UIColor.baeminBackgroundWhite.cgColor
        ]
        // 중앙의 y 0에서 중앙의 y 1로 이동한다.
        $0.startPoint = CGPoint(x: 0.5, y: 0.0)
        $0.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        $0.locations = [0, 1.0]
    }
    
    private lazy var rankGradientView = UIView().then {
        $0.layer.addSublayer(rankGradientLayer)
    }
    
    private lazy var rankLabel = UILabel().then {
        $0.text = "우리 동네 한그릇 인기 랭킹"
        $0.textColor = .white
        $0.font = UIFont(name: Pretendard.SemiBold.name(), size: 18)
    }
    
    private lazy var whiteInfoImage = UIImageView().then {
        $0.image = .infoWhite
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var seeAllButton = UIButton().then {
        $0.setTitle("전체보기 >", for: .normal)
        $0.titleLabel?.font = UIFont(name: Pretendard.Regular.name(), size: 14)
        $0.setTitleColor(.white, for: .normal)
    }
    
    lazy var rankCollectionView: BaeminUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = BaeminUICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.type = .rank
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .baeminBackgroundWhite
        setSubviews([stickyHeader,
                        locationButton, cartButton, notificationButton, discountButton,
                        searchTextField, searchIcon,
                     feedScrollView])
        feedScrollView.addSubview(feedContentView)
        [headGradientView, bmartImageView, promotionButton,
         tapViewCollectionView,
         categoryCollectionView,
         marketCollectionView,
         bannerCollectionView,
         rankGradientView, rankLabel, whiteInfoImage, seeAllButton,
         rankCollectionView, ].forEach {
            feedContentView.addSubview($0)
        }
        setHeaderUIs()
        setFeedUIs()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 제약 조건이 모두 결정된 이후에 Gradient의 frame을 잡아주어야 한다.
        headGradientLayer.frame = headGradientView.bounds
        rankGradientLayer.frame = rankGradientView.bounds
    }
    
    func setHeaderUIs() {
        stickyHeader.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(74)
        }
        
        locationButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.top.equalTo(stickyHeader)
        }
        
        cartButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.trailing.top.equalTo(stickyHeader)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(stickyHeader)
            make.trailing.equalTo(cartButton.snp.leading).offset(-12)
        }
        
        discountButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(stickyHeader)
            make.trailing.equalTo(notificationButton.snp.leading).offset(-12)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.horizontalEdges.bottom.equalTo(stickyHeader)
        }
        
        searchIcon.snp.makeConstraints { make in
            make.trailing.equalTo(searchTextField).inset(20)
            make.centerY.equalTo(searchTextField)
        }
    }
    
    func setFeedUIs() {
        // Scroll이 가능하게 해주는 영역
        feedScrollView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(stickyHeader.snp.bottom)
        }
        
        feedContentView.snp.makeConstraints { make in
            make.edges.equalTo(feedScrollView)
            make.width.equalTo(feedScrollView)
            make.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        headGradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(feedContentView)
            make.top.equalTo(feedContentView).offset(20)
            make.height.equalTo(100)
        }
        
        bmartImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        
        promotionButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(bmartImageView.snp.bottom).offset(5)
        }
        
        tapViewCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(headGradientView.snp.bottom).offset(-20)
            make.height.equalTo(48)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(tapViewCollectionView.snp.bottom).offset(2)
            make.height.equalTo(233) // 10 + 168 + 21
        }
        
        marketCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(10)
            make.height.equalTo(96)
        }
        
        bannerCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(marketCollectionView.snp.bottom).offset(10)
            make.height.equalTo(114)
        }
        
        rankGradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(10)
            make.height.equalTo(100)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(rankGradientView.snp.top).offset(24)
        }
        
        whiteInfoImage.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.equalTo(rankLabel.snp.trailing).offset(5)
            make.centerY.equalTo(rankLabel)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalTo(rankGradientView.snp.trailing).inset(16)
            make.height.equalTo(20)
            make.centerY.equalTo(rankLabel)
        }
        
        rankCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(rankGradientView.snp.bottom).offset(-40)
            make.height.equalTo(243)
            make.bottom.equalToSuperview().offset(-30)
        }
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    func setSubviews(_ views: [UIView]) {
        views.forEach({ self.addSubview($0) })
    }
}

#Preview {
    BaeminFeedViewController()
}
