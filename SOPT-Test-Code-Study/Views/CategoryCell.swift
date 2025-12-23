//
//  CategoryCell.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/7/25.
//

import UIKit
import SnapKit
import Then

final class CategoryCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var goDetail: (() -> Void)?
    var data: [CategoryCellData]?
    
    private lazy var mainCollection: BaeminUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = BaeminUICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.type = .categoryCell
        collection.isPagingEnabled = true
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        
        return collection
    }()
    
    private lazy var goDetailButton = UIButton().then {
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(goDetailTapped), for: .touchUpInside)
    }
    
    private lazy var moreInfoHStack = UIStackView().then {
        $0.axis = .horizontal
    }
    
    private lazy var moreInfoLabel = UILabel().then {
        $0.font = UIFont(name: Pretendard.Bold.name(), size: 14)
        $0.text = "음식배달"
    }
    
    private lazy var moreInfoSubLabel = UILabel().then {
        $0.font = UIFont(name: Pretendard.Regular.name(), size: 14)
        $0.text = "에서 더보기  "
    }
    
    private lazy var moreInfoArrowImageView = UIImageView().then {
        $0.image = .rightArrow
        $0.contentMode = .scaleAspectFit
    }
    
    @objc func goDetailTapped() {
        self.goDetail?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        mainCollection.register(PebbleCell.self, forCellWithReuseIdentifier: PebbleCell.identifier())
    }
    
    func setUI() {
        self.backgroundColor = .baeminBackgroundWhite
        self.addSubview(mainCollection)
        self.addSubview(goDetailButton)
        self.addSubview(moreInfoHStack)
        
        mainCollection.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.size.equalTo(201)
        }
        
        goDetailButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(mainCollection.snp.bottom).offset(2)
            make.height.equalTo(34)
        }
        
        moreInfoHStack.snp.makeConstraints { make in
            make.center.equalTo(goDetailButton)
            make.height.equalTo(34)
        }

        moreInfoHStack.addArrangedSubview(moreInfoLabel)
        moreInfoHStack.addArrangedSubview(moreInfoSubLabel)
        moreInfoHStack.addArrangedSubview(moreInfoArrowImageView)
        
        moreInfoArrowImageView.snp.makeConstraints { make in
            make.size.equalTo(6)
        }
    }
    
    func configure(data: [CategoryCellData], destination: String,
        delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.data = data
        mainCollection.dataSource = self
        mainCollection.delegate = self
        mainCollection.reloadData()
        
        moreInfoLabel.text = destination
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PebbleCell.identifier(), for: indexPath) as? PebbleCell else {
        return UICollectionViewCell()
        }
        cell.configure(data?[indexPath.row] ?? .init(image: UIImage(), name: ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 62, height: 78)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 32, bottom: 10, right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
