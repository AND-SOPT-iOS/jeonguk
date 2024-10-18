//
//  ViewController.swift
//  SOPT_Week2_UIDeepening
//
//  Created by 정정욱 on 10/12/24.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // 앱 아이콘
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "toss") // 앱 아이콘 이미지
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // 앱 이름
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "토스"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    // 간략한 설명
    private lazy var appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "금융이 쉬워진다"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    // 열기 버튼
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("열기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        let symbolImage = UIImage(systemName: "square.and.arrow.up")
        
        // 심볼 크기 설정 (대형 사이즈)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25) // 원하는 크기 설정
        let largeSymbolImage = symbolImage?.withConfiguration(largeConfig)
        
        // 버튼에 심볼 이미지 적용
        button.setImage(largeSymbolImage, for: .normal)
        
        // 심볼 색상 설정
        button.tintColor = .systemBlue
        
        // 버튼 모양 설정
        button.layer.cornerRadius = 8
        
        // 버튼의 이미지 콘텐츠 모드 설정 (가득 채우기)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()

    
    // 스크린샷 갤러리
    private lazy var screenshotsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    // 상세 설명
    private lazy var detailedDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이곳에 앱의 자세한 설명이 들어갑니다."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.backgroundColor = .black
        
        
        // 컨텐츠 뷰에 하위 뷰들 추가
        [appIconImageView, appNameLabel, appDescriptionLabel, downloadButton, shareButton, screenshotsScrollView, detailedDescriptionLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)  // 스크롤뷰의 가로 크기를 동일하게 맞춰줌
        }
        
        // 앱 아이콘
        appIconImageView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(20)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.size.equalTo(CGSize(width: 120, height: 120)) // 정사각형으로 설정
        }
        
        
        // 앱 이름
        appNameLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top) // 동일한 위치로 지정
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(20) // 얼마나 떨어질지 지정
            $0.width.equalTo(100)
        }
        
        
        // 앱 간단 설명
        appDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(20)
            $0.width.equalTo(100)
        }
        
        // 열기/다운로드 버튼
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(20)
            $0.height.equalTo(34)
            $0.width.equalTo(80)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(downloadButton.snp.top)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
            $0.width.equalTo(50)
        }
     
        
        // 스크린샷 갤러리 (가로 스크롤)
        screenshotsScrollView.snp.makeConstraints {
            $0.top.equalTo(downloadButton.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.height.equalTo(200)
        }
        
        // 상세 설명
        detailedDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(screenshotsScrollView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)  // 스크롤 뷰가 끝나는 지점
        }
    }
}
