//
//  AppCardCell.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/30/24.
//

import UIKit
import SwiftUI
import SnapKit
import Then

final class AppRecommendationCell: UICollectionViewCell {
    
    static let identifier = "AppRecommendationCell"
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.numberOfLines = 0
    }
    
    private let appDscTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
    }
    
//    private let appSubDscTitle = UILabel().then {
//        $0.font = .systemFont(ofSize: 16, weight: .light)
//        $0.numberOfLines = 0
//    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 0
    }
    
    
    // 기본 초기화 메서드 구현
     override init(frame: CGRect) {
         super.init(frame: frame)
         setUI()
         setLayout()
     }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(appDscTitle)
//        stackView.addArrangedSubview(appSubDscTitle)
        
        addSubview(imageView)
        addSubview(stackView)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
            //  슈퍼뷰(부모 뷰)의 하단보다 작거나 같도록 설정합니다. 즉, 현재 뷰의 하단이 부모 뷰의 하단을 넘지 않도록 하는 제약을 추가합니다.
            

        }
    }
    

}


extension AppRecommendationCell{
    
    // Photo 객체를 바인딩하는 메소드입니다.
    func bind(_ app: App) {
         titleLabel.text = app.title
         appDscTitle.text = app.subTitle
//         appSubDscTitle.text = app.category
        imageView.image = app.iconImage
     }
    
}
