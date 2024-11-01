//
//  AppTableViewCell.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/30/24.
//

import UIKit
import SwiftUI
import SnapKit
import Then


class AppTableViewCell: UITableViewCell {
    
    static let identifier = "AppTableViewCell"
    
    // UI Components
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let rankingLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .darkGray
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .black
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .gray
    }
    
    private let downloadButton = UIButton().then {
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(rankingLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(downloadButton)
    }
    
    private func setupLayout() {
        // 아이콘과 랭킹 라벨의 제약 조건 설정
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        rankingLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.centerY.equalTo(iconImageView)
        }
        
        // 타이틀과 서브타이틀을 위한 수직 스택 뷰 생성
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        titleStackView.axis = .vertical // 세로 방향으로 설정
        titleStackView.spacing = 4 // 요소 간의 간격 설정
        titleStackView.translatesAutoresizingMaskIntoConstraints = false // 자동 제약 조건 비활성화

        // 슈퍼뷰에 스택 뷰 추가
        addSubview(titleStackView)

        // 타이틀 스택 뷰 제약 조건 설정
        titleStackView.snp.makeConstraints { make in
            make.leading.equalTo(rankingLabel.snp.trailing).offset(12) // 랭킹 라벨 오른쪽으로부터 여백
            make.top.equalTo(iconImageView.snp.top) // 슈퍼뷰의 상단으로부터 여백
          
        }
        
        // 다운로드 버튼 제약 조건 설정
        downloadButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }


    
    func configure(app: App) {
        iconImageView.image = app.iconImage
        rankingLabel.text = app.ranking.description
        titleLabel.text = app.title
        subTitleLabel.text = app.subTitle
        downloadButton.setTitle(app.downloadState.title, for: .normal)
    }
}
