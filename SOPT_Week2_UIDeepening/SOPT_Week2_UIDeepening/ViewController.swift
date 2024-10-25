//
//  ViewController.swift
//  SOPT_Week2_UIDeepening
//
//  Created by 정정욱 on 10/12/24.
//

import UIKit
import SnapKit
import SwiftUI


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
    
    
    
    // MARK: - infoView
    // 평가, 수상, 연령, 차트를 위한 정보 표시 뷰
    
    private lazy var ratingView: UIView = {
        let view = UIView()
        
        // 전체 수직 스택뷰 생성
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4 // 간격 설정
        verticalStackView.alignment = .center // 중앙 정렬
        
        // 평가 텍스트 추가
        let ratingLabel = UILabel()
        ratingLabel.text = "8.4만개의 평가" // 평가 수치
        ratingLabel.textColor = .systemGray
        ratingLabel.font = UIFont.systemFont(ofSize: 10)
        
        // 별점 뷰 생성
        let starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.spacing = 4 // 별 사이의 간격
        starStackView.alignment = .center
        
        // 채워진 별 추가
        for _ in 0..<4 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = .systemGray // 별 색상
            starImageView.contentMode = .scaleAspectFit // 크기 조절 모드
            starImageView.translatesAutoresizingMaskIntoConstraints = false // 제약 설정 가능
            starImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true // 너비 설정
            starImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true // 높이 설정
            starStackView.addArrangedSubview(starImageView)
        }
        
        // 반쪽 별 추가
        let halfStarImageView = UIImageView()
        halfStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
        halfStarImageView.tintColor = .systemGray // 별 색상
        halfStarImageView.contentMode = .scaleAspectFit // 크기 조절 모드
        halfStarImageView.translatesAutoresizingMaskIntoConstraints = false // 제약 설정 가능
        halfStarImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true // 너비 설정
        halfStarImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true // 높이 설정
        starStackView.addArrangedSubview(halfStarImageView)
        
        
        // 별점 레이블 추가
        let scoreLabel = UILabel()
        scoreLabel.text = "4.4"
        scoreLabel.textColor = .systemGray // 점수 색상
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        // 수직 스택뷰에 추가
        verticalStackView.addArrangedSubview(ratingLabel) // 평가 수치
        verticalStackView.addArrangedSubview(scoreLabel) // 점수
        verticalStackView.addArrangedSubview(starStackView) // 별점
        
        view.addSubview(verticalStackView)
        
        // 스택뷰 제약 설정
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        return view
    }()
    
    
    
    
    
    private lazy var awardView: UIView = {
        let view = UIView()
        
        // 전체 수직 스택뷰 생성
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4 // 간격 설정
        verticalStackView.alignment = .center // 중앙 정렬
        verticalStackView.distribution = .fillEqually // 동일한 크기로 분배
        
        // 수상 텍스트 추가
        let awardLabel = UILabel()
        awardLabel.text = "수상" // 수상 정보
        awardLabel.textColor = .systemGray
        awardLabel.font = UIFont.systemFont(ofSize: 10)
        
        // 사람 아이콘 추가
        let personImageView = UIImageView()
        personImageView.image = UIImage(systemName: "person.fill") // 사람 아이콘
        personImageView.tintColor = .systemBlue // 아이콘 색상
        personImageView.contentMode = .scaleAspectFit // 크기 조절
        
        // 앱 이름 텍스트 추가
        let appNameLabel = UILabel()
        appNameLabel.text = "앱" // 앱 이름
        appNameLabel.textColor = .systemGray
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 10)
        
        // 수직 스택뷰에 추가
        verticalStackView.addArrangedSubview(awardLabel) // 수상 정보
        verticalStackView.addArrangedSubview(personImageView) // 사람 아이콘
        verticalStackView.addArrangedSubview(appNameLabel) // 앱 이름
        
        view.addSubview(verticalStackView)
        
        // 스택뷰 제약 설정
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        return view
    }()
    
    
    
    private lazy var ageView: UIView = {
        let view = UIView()
        
        // 전체 수직 스택뷰 생성
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4 // 간격 설정
        verticalStackView.alignment = .center // 중앙 정렬
        
        // 나이 텍스트 추가
        let ageLabel = UILabel()
        ageLabel.text = "연령" // 수상 정보
        ageLabel.textColor = .systemGray
        ageLabel.font = UIFont.systemFont(ofSize: 10)
        
        
        // 별점 레이블 추가
        let scoreLabel = UILabel()
        scoreLabel.text = "4+"
        scoreLabel.textColor = .systemGray // 점수 색상
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        // 앱 이름 텍스트 추가
        let appNameLabel = UILabel()
        appNameLabel.text = "세" // 앱 이름
        appNameLabel.textColor = .systemGray
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 10)
        
        // 수직 스택뷰에 추가
        verticalStackView.addArrangedSubview(ageLabel) // 수상 정보
        verticalStackView.addArrangedSubview(scoreLabel) // 사람 아이콘
        verticalStackView.addArrangedSubview(appNameLabel) // 앱 이름
        
        view.addSubview(verticalStackView)
        
        // 스택뷰 제약 설정
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        return view
    }()
    
    
    
    private lazy var chartView: UIView = {
        let view = UIView()
        
        // 전체 수직 스택뷰 생성
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4 // 간격 설정
        verticalStackView.alignment = .center // 중앙 정렬
        
        // 나이 텍스트 추가
        let chartLabel = UILabel()
        chartLabel.text = "차트" // 수상 정보
        chartLabel.textColor = .systemGray
        chartLabel.font = UIFont.systemFont(ofSize: 10)
        
        
        // 별점 레이블 추가
        let chartLabel2 = UILabel()
        chartLabel2.text = "#5"
        chartLabel2.textColor = .systemGray // 점수 색상
        chartLabel2.font = UIFont.boldSystemFont(ofSize: 24)
        
        // 앱 이름 텍스트 추가
        let chartLabel3 = UILabel()
        chartLabel3.text = "금융" // 앱 이름
        chartLabel3.textColor = .systemGray
        chartLabel3.font = UIFont.boldSystemFont(ofSize: 10)
        
        // 수직 스택뷰에 추가
        verticalStackView.addArrangedSubview(chartLabel) // 수상 정보
        verticalStackView.addArrangedSubview(chartLabel2) // 사람 아이콘
        verticalStackView.addArrangedSubview(chartLabel3) // 앱 이름
        
        view.addSubview(verticalStackView)
        
        // 스택뷰 제약 설정
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        return view
    }()
    
    
    
    private lazy var infoStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [ratingView, awardView, ageView, chartView])
        stview.axis = .horizontal // 수평 방향
        stview.distribution = .fillEqually // 동일한 크기로 분배
        stview.spacing = 10 // 뷰 간의 간격
        return stview
    }()
    
    // infoStackView의 상단 및 하단 구분선 추가
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
    
    
    private lazy var versionView: UIView = {
        let view = UIView()
        
        // 전체 수직 스택뷰 생성
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4 // 간격 설정
        verticalStackView.alignment = .leading // 중앙 정렬
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 4 // 간격 설정
        horizontalStackView.alignment = .center // 중앙 정렬
        
        // 나이 텍스트 추가
        let chartLabel = UILabel()
        chartLabel.text = "새로운 소식" // 수상 정보
        chartLabel.textColor = .white
        chartLabel.font = UIFont.boldSystemFont(ofSize: 24) // bold 폰트로 설정
        
        // 화살표 아이콘
        let personImageView = UIImageView()
        personImageView.image = UIImage(systemName: "chevron.right") // 사람 아이콘
        personImageView.tintColor = .systemGray // 아이콘 색상
        personImageView.contentMode = .scaleAspectFit // 크기 조절
        
        horizontalStackView.addArrangedSubview(chartLabel)
        horizontalStackView.addArrangedSubview(personImageView)
        
        let chartLabel2 = UILabel()
        chartLabel2.text = "버전 5.185.0"
        chartLabel2.textColor = .systemGray // 점수 색상
        chartLabel2.font = UIFont.boldSystemFont(ofSize: 12)
        
        // 앱 이름 텍스트 추가
        let chartLabel3 = UILabel()
        chartLabel3.text = "5.185.0 구석구석 숨어있던 버그들을 잡았어요. " // 앱 이름
        chartLabel3.textColor = .white
        chartLabel3.font = UIFont.boldSystemFont(ofSize: 12)
        chartLabel3.numberOfLines = 0 // 자동 줄 바꿈 허용
        
        // 수직 스택뷰에 추가
        verticalStackView.addArrangedSubview(horizontalStackView) // 수상 정보
        verticalStackView.addArrangedSubview(chartLabel2) // 사람 아이콘
        verticalStackView.addArrangedSubview(chartLabel3) // 앱 이름
        
        view.addSubview(verticalStackView)
        
        // 스택뷰 제약 설정
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        
        // 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(versionViewTapped))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    
    @objc private func versionViewTapped() {
        let newVersionVC = NewVersionViewController() // 새로운 화면 인스턴스 생성
        newVersionVC.title = "새로운 소식"
        navigationController?.pushViewController(newVersionVC, animated: true)
    }
    
    
    // MARK: - 베너뷰
    private lazy var bannerLabel: UILabel = {
        let bannerLabel = UILabel()
        bannerLabel.text = "미리 보기" // 수상 정보
        bannerLabel.textColor = .white
        bannerLabel.font = UIFont.boldSystemFont(ofSize: 24) // bold 폰트로 설정
        return bannerLabel
    }()
    
    
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner")
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit // 비율을 맞추기 위해 수정
        return imageView
    }()
    
    
    
    private lazy var reviewView: UIView = {
        let view = UIView()
        
        // 전체 수직 스택뷰 생성
        let mainVStack = UIStackView()
        mainVStack.axis = .vertical
        mainVStack.spacing = 4
        mainVStack.alignment = .leading
        
        let titleAndArrowStackView = UIStackView()
        titleAndArrowStackView.axis = .horizontal
        titleAndArrowStackView.spacing = 4
        titleAndArrowStackView.alignment = .center
        
        // 제목 텍스트 추가
        let titleLabel = UILabel()
        titleLabel.text = "평가 및 리뷰"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        // 화살표 아이콘
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .systemGray
        arrowImageView.contentMode = .scaleAspectFit
        
        titleAndArrowStackView.addArrangedSubview(titleLabel)
        titleAndArrowStackView.addArrangedSubview(arrowImageView)
        
        // Tap Gesture Recognizer 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reviewTapped))
        titleAndArrowStackView.addGestureRecognizer(tapGesture)
        titleAndArrowStackView.isUserInteractionEnabled = true
        
        let ratingAndStarsStackView = UIStackView()
        ratingAndStarsStackView.axis = .horizontal
        ratingAndStarsStackView.spacing = 140 // max spacing은 직접 계산 필요
        ratingAndStarsStackView.alignment = .lastBaseline
        
        let ratingLabel = UILabel()
        ratingLabel.text = "4.4"
        ratingLabel.textColor = .white
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 54)
        
        let starsAndReviewsVStack = UIStackView()
        starsAndReviewsVStack.axis = .vertical
        starsAndReviewsVStack.spacing = 4
        starsAndReviewsVStack.alignment = .center
        
        // 별점 뷰 생성
        let starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.spacing = 4
        starStackView.alignment = .center
        
        for _ in 0..<4 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = .white
            starImageView.contentMode = .scaleAspectFit
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            starStackView.addArrangedSubview(starImageView)
        }
        
        let halfStarImageView = UIImageView()
        halfStarImageView.image = UIImage(systemName: "star.leadinghalf.filled")
        halfStarImageView.tintColor = .white
        halfStarImageView.contentMode = .scaleAspectFit
        halfStarImageView.translatesAutoresizingMaskIntoConstraints = false
        halfStarImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        halfStarImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        starStackView.addArrangedSubview(halfStarImageView)
        
        let reviewCountLabel = UILabel()
        reviewCountLabel.text = "8.4만개의 평가"
        reviewCountLabel.textColor = .systemGray
        reviewCountLabel.font = UIFont.boldSystemFont(ofSize: 18)
        reviewCountLabel.numberOfLines = 0
        
        starsAndReviewsVStack.addArrangedSubview(starStackView)
        starsAndReviewsVStack.addArrangedSubview(reviewCountLabel)
        
        ratingAndStarsStackView.addArrangedSubview(ratingLabel)
        ratingAndStarsStackView.addArrangedSubview(starsAndReviewsVStack)
        
        // 수직 스택뷰에 추가
        mainVStack.addArrangedSubview(titleAndArrowStackView)
        mainVStack.addArrangedSubview(ratingAndStarsStackView)
        
        view.addSubview(mainVStack)
        
        // 스택뷰 제약 설정
        mainVStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return view
    }()

    @objc private func reviewTapped() {
        let reviewVC = ReviewViewController() // 이동할 새로운 화면 생성
        reviewVC.delegate = self
        reviewVC.title = "평가 및 리뷰"
        navigationController?.pushViewController(reviewVC, animated: true)
    }

    
    
    
    private lazy var helpfulReviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "가장 도움이 되는 리뷰"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var helpfulReviewView: UIView = {
        
        
        let view = UIView()
        view.backgroundColor = .secondaryLabel
        view.layer.cornerRadius = 12 // 라운드 처리
        view.clipsToBounds = true // 코너 잘라내기
        
        // 전체 수직 스택뷰 생성
        let mainVStack = UIStackView()
        mainVStack.axis = .vertical
        mainVStack.spacing = 4
        mainVStack.alignment = .leading
        
        
        
        
        // 타이틀 추가
        let titleLabel = UILabel()
        titleLabel.text = "토스 UX 전 버전으로 해주세요" // 타이틀
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // 별점 및 날짜 HStack
        let starsAndDateHStack = UIStackView()
        starsAndDateHStack.axis = .horizontal
        starsAndDateHStack.spacing = 8
        starsAndDateHStack.alignment = .center
        
        // 별점 5개 생성
        let starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.spacing = 4
        starStackView.alignment = .center
        
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = .white
            starImageView.contentMode = .scaleAspectFit
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
            starStackView.addArrangedSubview(starImageView)
        }
        
        // 날짜 추가
        let dateLabel = UILabel()
        dateLabel.text = "9월 27일"
        dateLabel.textColor = .systemGray
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        
        let reviewTitleLabel = UILabel()
        reviewTitleLabel.text = "흑 운영자님 ㅠㅠ"
        reviewTitleLabel.textColor = .systemGray
        reviewTitleLabel.font = UIFont.systemFont(ofSize: 14)
        
        
        starsAndDateHStack.addArrangedSubview(starStackView)
        starsAndDateHStack.addArrangedSubview(dateLabel)
        starsAndDateHStack.addArrangedSubview(reviewTitleLabel)
        
        // 본문 내용 추가
        let reviewContentLabel = UILabel()
        reviewContentLabel.text = "UX 디자인 전 버전이 더 직관적이었고,"
        reviewContentLabel.textColor = .white
        reviewContentLabel.font = UIFont.systemFont(ofSize: 14)
        reviewContentLabel.numberOfLines = 0 // 여러 줄 허용
        
        // 스택뷰에 추가
        mainVStack.addArrangedSubview(titleLabel)
        mainVStack.addArrangedSubview(starsAndDateHStack)
        mainVStack.addArrangedSubview(reviewContentLabel)
        
        view.addSubview(mainVStack)
        
        
        mainVStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        return view
    }()
    
    
    private lazy var createReviewTitle: UILabel = {
        let label = UILabel()
        label.text = "탭하여 평가하기"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    
    private lazy var starButtons: [UIButton] = {
        var buttons: [UIButton] = []
        for index in 0..<5 {
            let button = UIButton()
            
            // 이미지 크기 설정
            let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
            let image = UIImage(systemName: index == 0 ? "star.fill" : "star")?.withConfiguration(configuration)
            
            button.setImage(image, for: .normal)
            button.tintColor = .systemBlue // 별 색상
            button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            button.tag = index // 버튼의 태그를 통해 별의 인덱스를 구분
            button.translatesAutoresizingMaskIntoConstraints = false
            

            
            buttons.append(button)
        }
        return buttons
    }()

    
    @objc private func starButtonTapped(_ sender: UIButton) {
        for (index, button) in starButtons.enumerated() {
            
            let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular)
        
            button.setImage(UIImage(systemName: index <= sender.tag ? "star.fill" : "star")?.withConfiguration(configuration), for: .normal)
        }
    }
    
    
    private lazy var createReviewAndAppInfoView: UIView = {
        let view = UIView()
        
        
        // 수평 스택뷰 생성
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20 // 두 버튼 간의 간격
        stackView.alignment = .center // 중앙 정렬
        stackView.distribution = .equalSpacing // 버튼 크기 동일하게 분배
        
        // 리뷰 작성 버튼
        let reviewButton = createButton(iconName: "square.and.pencil", title: "리뷰 작성")
       
        stackView.addArrangedSubview(reviewButton)
        
        // 앱 지원 버튼
        let supportButton = createButton(iconName: "questionmark.circle", title: "앱 지원")

        stackView.addArrangedSubview(supportButton)
        
        view.addSubview(stackView)
        
        // 스택뷰의 제약 설정
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview() // 뷰의 여백
        }
        
        return view
    }()
    
    private func createButton(iconName: String, title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .secondaryLabel
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        // 수평 스택뷰 생성
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8 // 아이콘과 레이블 간의 간격
        stackView.alignment = .center // 중앙 정렬
        stackView.distribution = .fill // 가로로 가득 차도록 설정
        
        // 아이콘 생성
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = .systemBlue
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints {
            $0.width.height.equalTo(24) // 아이콘 크기 설정
        }
        
        // 레이블 생성
        let label = UILabel()
        label.text = title
        label.textColor = .systemBlue
        label.textAlignment = .left // 왼쪽 정렬
        
        // 스택뷰에 아이콘과 레이블 추가
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(label)
        
        button.addSubview(stackView)
        
        // 스택뷰 제약 설정
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview() // 버튼의 중앙에 위치
        }
        
        // 버튼의 고정 너비 및 높이 설정
        button.snp.makeConstraints {
            $0.width.equalTo(170) // 원하는 너비
            $0.height.equalTo(60) // 원하는 높이
        }
        
        // 타이틀이 '리뷰 작성'일 때 액션 추가
        if title == "리뷰 작성" {
            button.addTarget(self, action: #selector(reviewTapped), for: .touchUpInside)
        }
        
        return button
    }
    
    
    
    
    
    
    
    
    // 상세 설명
    private lazy var detailedDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이곳에 앱의 자세한 설명이 들어갑니다."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    
    // 스크린샷 갤러리
    private lazy var screenshotsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
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
        [appIconImageView, appNameLabel, appDescriptionLabel, downloadButton, shareButton, screenshotsScrollView, detailedDescriptionLabel, infoStackView, topDivider, bottomDivider, versionView, bannerLabel, bannerImageView, reviewView, helpfulReviewTitleLabel, helpfulReviewView,    createReviewTitle, createReviewAndAppInfoView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)  // 가로 크기를 scrollView에 맞춤
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
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
            $0.width.equalTo(50)
            $0.height.equalTo(50) // 버튼 높이 설정
        }
        
        // 평가, 수상, 연령, 차트 정보 뷰 레이아웃 설정
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.bottom).offset(30)
            $0.leading.equalTo(contentView).inset(20) // 왼쪽 20pt 여백
            $0.trailing.equalTo(contentView).inset(-20) // 오른쪽 20pt 여백
            $0.height.equalTo(80) // 높이 설정 (필요에 따라 조정)
        }
        
        topDivider.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.top).offset(-10) // 위쪽으로 여백 조정
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(0.5) // 선의 높이
        }
        
        bottomDivider.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(10) // 아래쪽으로 여백 조정
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(0.5) // 선의 높이
        }
        
        versionView.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(30) // 아래쪽으로 여백 조정
            $0.leading.equalTo(contentView).inset(20) // 왼쪽 20pt 여백
            $0.trailing.equalTo(contentView).inset(-20) // 오른쪽 20pt 여백
            $0.height.greaterThanOrEqualTo(80) // 최소 높이 설정
        }
        
        
        
        // 베너
        // Auto Layout 제약 설정
        bannerLabel.snp.makeConstraints {
            $0.top.equalTo(versionView.snp.bottom).offset(20) // 아래쪽으로 여백 조정
            $0.leading.equalTo(contentView).inset(20) // 왼쪽 20pt 여백
            $0.trailing.equalTo(contentView).inset(-20) // 오른쪽 20pt 여백
        }
        
        bannerImageView.snp.makeConstraints {
            $0.top.equalTo(bannerLabel.snp.bottom).offset(20)
            $0.leading.equalTo(contentView).inset(20)
            //$0.trailing.equalTo(contentView).inset(-20)
            $0.height.equalTo(400)
            $0.width.equalTo(200)
        }
        
        
        reviewView.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.bottom).offset(20)
            $0.leading.equalTo(contentView).inset(20)
            $0.trailing.equalTo(contentView).inset(-20)
            $0.height.equalTo(100)
            
        }
        
        helpfulReviewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(reviewView.snp.bottom).offset(10)
            $0.leading.equalTo(contentView).inset(20)
            $0.trailing.equalTo(contentView).inset(-20)
            
        }
        
        helpfulReviewView.snp.makeConstraints {
            $0.top.equalTo(helpfulReviewTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(contentView).offset(20)  // 왼쪽 여백 20
            $0.trailing.equalTo(contentView).offset(-20)  // 오른쪽 여백 20
            $0.height.equalTo(150)
            
        }
        
        
        // 전체 수직 스택뷰 생성
        let mainVStack = UIStackView()
        mainVStack.axis = .vertical
        mainVStack.spacing = 4
        mainVStack.alignment = .center
        
        // starButtons를 수평 스택뷰에 추가
        let starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.spacing = 4 // 별 버튼 간의 간격
        starStackView.alignment = .center
        
        // starButtons 배열의 각 버튼을 starStackView에 추가
        starButtons.forEach { button in
            starStackView.addArrangedSubview(button)
        }

        // starStackView를 mainVStack에 추가
        
        
        // 수직 스택뷰에 추가
        mainVStack.addArrangedSubview(createReviewTitle)
        mainVStack.addArrangedSubview(starStackView)
        mainVStack.addArrangedSubview(createReviewAndAppInfoView)
        
        contentView.addSubview(mainVStack) // mainVStack을 contentView에 추가해야 함
        
        mainVStack.snp.makeConstraints {
            $0.top.equalTo(helpfulReviewView.snp.bottom).offset(20)
            $0.leading.equalTo(contentView).offset(20)  // 왼쪽 여백 20
            $0.trailing.equalTo(contentView).offset(-20)  // 오른쪽 여백 20
            $0.height.equalTo(150)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)  // 마지막 뷰의 bottom을 contentView에 연결
        }
        /*
         inset 메서드를 사용하는 경우에는 양쪽에 동일한 양의 여백을 넣을 때만 사용하고, 왼쪽과 오른쪽의 여백이 다르다면 leading과 trailing을 따로 설정하는 것이 좋습니다.
         */
        
        
        
        // 스크린샷 갤러리 (가로 스크롤)
        //        screenshotsScrollView.snp.makeConstraints {
        //            $0.top.equalTo(downloadButton.snp.bottom).offset(30)
        //            $0.leading.trailing.equalTo(contentView).inset(20)
        //            $0.height.equalTo(200)
        //        }
        
        // 상세 설명
        //        detailedDescriptionLabel.snp.makeConstraints {
        //            $0.top.equalTo(screenshotsScrollView.snp.bottom).offset(20)
        //            $0.leading.trailing.equalTo(contentView).inset(20)
        //            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)  // contentView의 bottom과 연결
        //        }
        
        
    }
    
    
}



// 파트장 tip 구분을 위해 extension 사용
extension ViewController: ReviewDelegate {
    // 파트장 tip 구분을 위해 extension 사용
    func dataBind(titleText: String, subtitleText dateText: String, userInput reviewText: String) {
           // helpfulReviewView 내부의 UILabel을 찾고 텍스트를 업데이트
           if let titleLabel = (helpfulReviewView.subviews.first as? UIStackView)?.arrangedSubviews[0] as? UILabel {
               titleLabel.text = titleText
           }
           
           if let dateLabel = (helpfulReviewView.subviews.first as? UIStackView)?.arrangedSubviews[1].subviews[2] as? UILabel {
               dateLabel.text = dateText
           }
           
           if let reviewContentLabel = (helpfulReviewView.subviews.first as? UIStackView)?.arrangedSubviews[2] as? UILabel {
               reviewContentLabel.text = reviewText
           }
       }

}



struct ViewController_PreViews: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}


