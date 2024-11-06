//
//  AppRecommendationCardVIew.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/31/24.
//

import UIKit

class AppRecommendationCardView: UIView {
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false // 수평 스크롤바 숨김
    }
    
    private var appList: [App] = App.apps // 데이터 소스
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        setLayout()
        setCollectionView()
    }
    
    private func setUI() {
        addSubview(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(300)
        }
    }

    private func setCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        
        // 하나의 셀만 보이도록 크기 설정
        let itemWidth = UIScreen.main.bounds.width // 화면 너비와 동일
        let itemSize = CGSize(width: itemWidth, height: 290) // 높이를 150으로 설정
        flowLayout.itemSize = itemSize

        // 아이템 간격을 최소화
        flowLayout.minimumLineSpacing = 0 // 수평 간격을 0으로 설정
        flowLayout.scrollDirection = .horizontal // 가로 스크롤 설정

        collectionView.do {
            $0.setCollectionViewLayout(flowLayout, animated: false)
            $0.register(
                AppRecommendationCardCell.self,
                forCellWithReuseIdentifier: AppRecommendationCardCell.identifier
            )
            $0.delegate = self
            $0.dataSource = self
        }
    }

}


// UICollectionViewDelegate, UICollectionViewDataSource 구현
extension AppRecommendationCardView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(
                withReuseIdentifier: AppRecommendationCardCell.identifier,
                for: indexPath
        ) as? AppRecommendationCardCell else {
            return UICollectionViewCell()
        }

        // App 객체를 바인딩
        item.bind(appList[indexPath.row])
        return item
    }
}

#if DEBUG
import SwiftUI

struct AppRecommendationCardView_Previews: PreviewProvider {
    static var previews: some View {
        AppRecommendationCardView().toPreview()
    }
}
#endif
