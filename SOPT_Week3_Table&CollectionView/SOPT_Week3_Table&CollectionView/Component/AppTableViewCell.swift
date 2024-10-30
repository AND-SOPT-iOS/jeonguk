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
    
    private let appIconView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private let apptitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.numberOfLines = 2
    }
    
    private let appDscTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
    }
    
    private let appinstallbutton = UIButton().then {
        $0.setTitle("설치", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.3
        $0.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    
    
    private let vstackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
    }
    
    private let hstackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        setLayout()
    }
    
    // 편의 이니셜라이저 (Convenience Initializer)
    convenience init(appIcon: UIImage, title: String, description: String) {
        self.init(style: .default, reuseIdentifier: nil) // 기본 지정 이니셜라이저 호출
        self.appIconView.image = appIcon
        self.apptitleLabel.text = title
        self.appDscTitle.text = description
    }
    
    
    private func setUI() {
        vstackView.addArrangedSubview(apptitleLabel)
        vstackView.addArrangedSubview(appDscTitle)
        
        hstackView.addArrangedSubview(appIconView)
        hstackView.addArrangedSubview(vstackView)
        hstackView.addArrangedSubview(appinstallbutton)
        
        
        addSubview(hstackView)
    }
    
    private func setLayout() {
        appIconView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(80)
        }
        
        hstackView.snp.makeConstraints {
            $0.top.equalTo(appIconView)
            $0.leading.equalTo(appIconView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
        }
    }
    
}
