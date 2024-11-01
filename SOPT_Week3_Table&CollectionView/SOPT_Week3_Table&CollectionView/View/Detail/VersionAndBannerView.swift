//
//  VersionAndReviewView.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 11/1/24.
//

import UIKit
import SnapKit
import Then

class VersionAndReviewView: UIView {

    private lazy var versionView: UIView = {
        let view = UIView()
        
        let verticalStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .leading
        }

        let horizontalStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
        }

        let chartLabel = UILabel().then {
            $0.text = "새로운 소식"
            $0.textColor = .white
            $0.font = UIFont.boldSystemFont(ofSize: 24)
        }
        
        let personImageView = UIImageView().then {
            $0.image = UIImage(systemName: "chevron.right")
            $0.tintColor = .systemGray
            $0.contentMode = .scaleAspectFit
        }

        horizontalStackView.addArrangedSubview(chartLabel)
        horizontalStackView.addArrangedSubview(personImageView)

        let chartLabel2 = UILabel().then {
            $0.text = "버전 5.185.0"
            $0.textColor = .systemGray
            $0.font = UIFont.boldSystemFont(ofSize: 12)
        }

        let chartLabel3 = UILabel().then {
            $0.text = "5.185.0 구석구석 숨어있던 버그들을 잡았어요."
            $0.textColor = .white
            $0.font = UIFont.boldSystemFont(ofSize: 12)
            $0.numberOfLines = 0
        }

        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(chartLabel2)
        verticalStackView.addArrangedSubview(chartLabel3)

        view.addSubview(verticalStackView)

        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(versionViewTapped))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    @objc private func versionViewTapped() {
        let newVersionVC = NewVersionViewController()
        newVersionVC.title = "새로운 소식"
        // navigationController?.pushViewController(newVersionVC, animated: true)
    }
    
    private lazy var bannerView: UIView = {
        let view = UIView()
        view.addSubview(bannerLabel)
        view.addSubview(bannerImageView)

        bannerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        bannerImageView.snp.makeConstraints { make in
            make.top.equalTo(bannerLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200)
            make.bottom.equalToSuperview().offset(-16)
        }

        return view
    }()
    
    private lazy var bannerLabel: UILabel = {
        let label = UILabel().then {
            $0.text = "미리 보기"
            $0.textColor = .white
            $0.font = UIFont.boldSystemFont(ofSize: 24)
        }
        return label
    }()
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView().then {
            $0.image = UIImage(named: "banner")
            $0.layer.cornerRadius = 18
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFit
        }
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(versionView)
        addSubview(bannerView)
    }

    private func setupConstraints() {
        versionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(versionView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
