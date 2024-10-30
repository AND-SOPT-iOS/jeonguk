//
//  AppRecommendationCardCell.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/31/24.
//

import UIKit
import SwiftUI
import SnapKit
import Then

final class AppRecommendationCardCell: UICollectionViewCell {
    
    static let identifier = "AppRecommendationCardCell"
    
    private let miniTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.text = "지금 이용 가능"
        $0.textColor = .systemBlue
        $0.numberOfLines = 0
    }
    
    private let appDscTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    private let appSubDscTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .light)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 2
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
        stackView.addArrangedSubview(miniTitleLabel)
        stackView.addArrangedSubview(appDscTitle)
        stackView.addArrangedSubview(appSubDscTitle)
        stackView.addArrangedSubview(imageView)
        addSubview(stackView)
    }
    
    private func setLayout() {
        // stackView의 제약 조건
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16) // 슈퍼뷰의 가장자리에 여백 추가
        }

        // imageView의 크기 제약 설정
        imageView.snp.makeConstraints {
            $0.height.equalTo(180) // 이미지 높이를 줄임 (200에서 150으로 조정)
            $0.leading.trailing.equalToSuperview() // 슈퍼뷰의 왼쪽, 오른쪽 여백 추가
        }

        // 각 UILabel의 높이와 유연성을 확인합니다
        appDscTitle.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(20) // 최소 높이 설정 (필요에 따라 조정 가능)
        }

        appSubDscTitle.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(20) // 최소 높이 설정 (필요에 따라 조정 가능)
        }
    }



}


extension AppRecommendationCardCell{
    

    func bind(_ app: App) {
        appDscTitle.text = app.title
        appSubDscTitle.text = app.subTitle
         imageView.image = app.ThumbnailImages[0]
     }
    
}

