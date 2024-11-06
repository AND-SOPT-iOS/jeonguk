//
//  AppDtailViewController.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 11/1/24.
//

import UIKit
import SnapKit
import Then
import SwiftUI

class AppDetailViewController: UIViewController {
    
    private var app: App
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var infoView = InfoView()
    private lazy var versionAndReviewView = VersionAndReviewView()
    private lazy var reviewView = ReviewView()
    
    // App icon
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = app.iconImage
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // App name
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = app.title
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    // Brief description
    private lazy var appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = app.subTitle
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    // Download button
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle(app.downloadState.title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        return button
    }()
    
    // Share button
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        let symbolImage = UIImage(systemName: "square.and.arrow.up")
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25)
        let largeSymbolImage = symbolImage?.withConfiguration(largeConfig)
        
        button.setImage(largeSymbolImage, for: .normal)
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 8
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    // Dividers
    private lazy var topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private lazy var bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    // Detailed description
    private lazy var detailedDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이곳에 앱의 자세한 설명이 들어갑니다."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    // Screenshots gallery
    private lazy var screenshotsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    init(app: App) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(appIconImageView)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appDescriptionLabel)
        contentView.addSubview(downloadButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(detailedDescriptionLabel)
        contentView.addSubview(infoView)
        contentView.addSubview(topDivider)
        contentView.addSubview(bottomDivider)
        contentView.addSubview(versionAndReviewView)
        contentView.addSubview(reviewView)
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        // App icon
        appIconImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(20)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.size.equalTo(CGSize(width: 120, height: 120))
        }
        
        // App name
        appNameLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(20)
            $0.width.equalTo(100)
        }
        // App brief description
        appDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(20)
            $0.width.equalTo(100)
        }
        
        // Download button
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(20)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        // Share button
        shareButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
        
        // Info view layout
        infoView.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.bottom).offset(30)
            $0.leading.equalTo(contentView).inset(20)
            $0.trailing.equalTo(contentView).inset(-20)
            $0.height.equalTo(80)
        }
        
        // Top divider layout
        topDivider.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.top).offset(-10)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(0.5)
        }
        
        // Bottom divider layout
        bottomDivider.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(0.5)
        }
        
        // Version and review view layout
        versionAndReviewView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(30)
            $0.leading.equalTo(contentView).inset(20)
            $0.trailing.equalTo(contentView).inset(-20)
            $0.height.greaterThanOrEqualTo(80)
        }
        
        // Detailed description layout
        detailedDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(versionAndReviewView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(20)
        }
        
        // Screenshots scroll view layout
        screenshotsScrollView.snp.makeConstraints {
            $0.top.equalTo(detailedDescriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.height.equalTo(200)
        }
        
        // Review view layout
        reviewView.snp.makeConstraints {
            $0.top.equalTo(screenshotsScrollView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20) // Ensure contentView height is set
        }
    }
    
}



//extension AppDetailViewController: ReviewDelegate {
//
//    func dataBind(titleText: String, subtitleText dateText: String, userInput reviewText: String) {
//           // helpfulReviewView 내부의 UILabel을 찾고 텍스트를 업데이트
//           if let titleLabel = (helpfulReviewView.subviews.first as? UIStackView)?.arrangedSubviews[0] as? UILabel {
//               titleLabel.text = titleText
//           }
//
//           if let dateLabel = (helpfulReviewView.subviews.first as? UIStackView)?.arrangedSubviews[1].subviews[2] as? UILabel {
//               dateLabel.text = dateText
//           }
//
//           if let reviewContentLabel = (helpfulReviewView.subviews.first as? UIStackView)?.arrangedSubviews[2] as? UILabel {
//               reviewContentLabel.text = reviewText
//           }
//       }
//
//}
//


