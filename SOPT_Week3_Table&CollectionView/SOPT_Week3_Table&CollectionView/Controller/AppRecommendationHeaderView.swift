//
//  AppRecommendationHeaderView.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/31/24.
//

import UIKit
import SnapKit

class AppRecommendationHeaderView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .left // 텍스트 정렬
    }
    
    private lazy var imageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true // 이미지 클리핑
        $0.tintColor = .gray // 색상 조정
    }
    
    private lazy var dscLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textAlignment = .left // 텍스트 정렬
    }
    
    // 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addTapGesture() // 제스처 인식기 추가
        isUserInteractionEnabled = true // 사용자 상호작용 가능하게 설정
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // UI 설정
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(dscLabel)
        
        // Auto Layout 설정
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview() // 상단 왼쪽에 배치
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel) // titleLabel과 수직 중앙 정렬
            $0.leading.equalTo(titleLabel.snp.trailing).offset(3) // titleLabel의 오른쪽에 위치, 간격 3
            $0.width.height.equalTo(24) // 이미지 크기 설정 (필요에 따라 변경 가능)
        }
        
        dscLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4) // titleLabel 아래에 위치
            $0.leading.equalToSuperview() // 왼쪽에 맞춤
            $0.trailing.equalToSuperview() // 오른쪽에도 맞춤
        }
    }
    
    
    // 외부에서 제목과 설명 텍스트를 설정할 수 있는 메서드
    func configure(title: String, description: String) {
        titleLabel.text = title
        dscLabel.text = description
    }
    
    // Tap Gesture 추가
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    // 헤더 클릭 시 호출되는 메서드
    @objc private func headerTapped() {
        print("Header tapped!") // 이벤트가 발생하는지 확인
        headerTapAction?()
    }
    
    // 클로저를 통해 헤더 클릭 이벤트를 전달합니다.
    var headerTapAction: (() -> Void)?
}
