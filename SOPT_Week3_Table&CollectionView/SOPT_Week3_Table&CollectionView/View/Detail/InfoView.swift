//
//  AwardView.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 11/1/24.
//

import UIKit
import SnapKit
import Then

class InfoView: UIView {
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        
        let verticalStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .center
        }
        
        let ratingLabel = UILabel().then {
            $0.text = "8.4만개의 평가"
            $0.textColor = .systemGray
            $0.font = UIFont.systemFont(ofSize: 10)
        }
        
        let starStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
        }
        
        for _ in 0..<4 {
            let starImageView = UIImageView().then {
                $0.image = UIImage(systemName: "star.fill")
                $0.tintColor = .systemGray
                $0.contentMode = .scaleAspectFit
                $0.snp.makeConstraints { make in
                    make.size.equalTo(16)
                }
            }
            starStackView.addArrangedSubview(starImageView)
        }
        
        let halfStarImageView = UIImageView().then {
            $0.image = UIImage(systemName: "star.leadinghalf.filled")
            $0.tintColor = .systemGray
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints { make in
                make.size.equalTo(16)
            }
        }
        starStackView.addArrangedSubview(halfStarImageView)
        
        let scoreLabel = UILabel().then {
            $0.text = "4.4"
            $0.textColor = .systemGray
            $0.font = UIFont.boldSystemFont(ofSize: 24)
        }
        
        verticalStackView.addArrangedSubview(ratingLabel)
        verticalStackView.addArrangedSubview(scoreLabel)
        verticalStackView.addArrangedSubview(starStackView)
        
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var awardView: UIView = {
        let view = UIView()
        
        let verticalStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
        
        let awardLabel = UILabel().then {
            $0.text = "수상"
            $0.textColor = .systemGray
            $0.font = UIFont.systemFont(ofSize: 10)
        }
        
        let personImageView = UIImageView().then {
            $0.image = UIImage(systemName: "person.fill")
            $0.tintColor = .systemBlue
            $0.contentMode = .scaleAspectFit
        }
        
        let appNameLabel = UILabel().then {
            $0.text = "앱"
            $0.textColor = .systemGray
            $0.font = UIFont.boldSystemFont(ofSize: 10)
        }
        
        verticalStackView.addArrangedSubview(awardLabel)
        verticalStackView.addArrangedSubview(personImageView)
        verticalStackView.addArrangedSubview(appNameLabel)
        
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var ageView: UIView = {
        let view = UIView()
        
        let verticalStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .center
        }
        
        let ageLabel = UILabel().then {
            $0.text = "연령"
            $0.textColor = .systemGray
            $0.font = UIFont.systemFont(ofSize: 10)
        }
        
        let scoreLabel = UILabel().then {
            $0.text = "4+"
            $0.textColor = .systemGray
            $0.font = UIFont.boldSystemFont(ofSize: 24)
        }
        
        let appNameLabel = UILabel().then {
            $0.text = "세"
            $0.textColor = .systemGray
            $0.font = UIFont.boldSystemFont(ofSize: 10)
        }
        
        verticalStackView.addArrangedSubview(ageLabel)
        verticalStackView.addArrangedSubview(scoreLabel)
        verticalStackView.addArrangedSubview(appNameLabel)
        
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var chartView: UIView = {
        let view = UIView()
        
        let verticalStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .center
        }
        
        let chartLabel = UILabel().then {
            $0.text = "차트"
            $0.textColor = .systemGray
            $0.font = UIFont.systemFont(ofSize: 10)
        }
        
        let chartLabel2 = UILabel().then {
            $0.text = "#5"
            $0.textColor = .systemGray
            $0.font = UIFont.boldSystemFont(ofSize: 24)
        }
        
        let chartLabel3 = UILabel().then {
            $0.text = "금융"
            $0.textColor = .systemGray
            $0.font = UIFont.boldSystemFont(ofSize: 10)
        }
        
        verticalStackView.addArrangedSubview(chartLabel)
        verticalStackView.addArrangedSubview(chartLabel2)
        verticalStackView.addArrangedSubview(chartLabel3)
        
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [ratingView, awardView, ageView, chartView])
        stview.axis = .horizontal
        stview.distribution = .fillEqually
        stview.spacing = 10
        return stview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(infoStackView)
        
        infoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
