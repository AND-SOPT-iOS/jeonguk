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
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .black
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
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
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        rankingLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.centerY.equalTo(iconImageView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankingLabel.snp.trailing) // Removed offset
            make.top.equalToSuperview().offset(12)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-12)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-12)
        }
        
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
