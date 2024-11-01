//
//  mainViewController.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/30/24.
//


import UIKit
import SnapKit
import Then


class MainViewController: UIViewController {
    
    
    lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .systemBackground
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        // 스크롤 뷰에 콘텐츠 뷰 추가
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        
        let mainPromotionView = AppRecommendationCardView()
        
        let headerView = AppRecommendationHeaderView()
        headerView.configure(title: "iPhone 필수 앱", description: "에디터가 직접 고른 추천 앱으로 시작하세요")
        headerView.headerTapAction = { [weak self] in
            self?.navigateToTableView()
        }
        
        let headerView2 = AppRecommendationHeaderView()
        headerView2.configure(title: "지금 주목해야 할 앱", description: "새로 나온 앱과 업데이트")
        headerView2.headerTapAction = { [weak self] in
            self?.navigateToTableView()
        }
        
        let appRecommendationView1 = AppRecommendationView()
        let appRecommendationView2 = AppRecommendationView()
        
        contentView.addSubview(mainPromotionView)
        contentView.addSubview(headerView)
        contentView.addSubview(appRecommendationView1)
        contentView.addSubview(headerView2)
        contentView.addSubview(appRecommendationView2)
        
        // 레이아웃 설정
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview() // 스크롤 뷰가 슈퍼뷰에 맞도록 설정
        }
        
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview() // 콘텐츠 뷰가 스크롤 뷰의 상하에 맞도록 설정
            $0.leading.trailing.equalToSuperview() // 좌우 여백 설정
            $0.width.equalTo(scrollView) // 스크롤 뷰와 같은 너비로 설정
        }
        
        
        mainPromotionView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16) // 콘텐츠 뷰의 상단에 위치
            $0.leading.trailing.equalToSuperview() // 좌우 여백 설정
            $0.height.equalTo(300)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(mainPromotionView.snp.bottom).offset(16) // 콘텐츠 뷰의 상단에 위치
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        appRecommendationView1.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        headerView2.snp.makeConstraints {
            $0.top.equalTo(appRecommendationView1.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        appRecommendationView2.snp.makeConstraints {
            $0.top.equalTo(headerView2.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
            $0.bottom.equalTo(contentView).offset(-16) // 마지막 뷰의 아래 여백 설정
        }
    }
    
    
    private func navigateToTableView() {
        let appRecommendationTableView = AppRecommendationTableView() // 이동할 테이블 뷰 컨트롤러

        // UINavigationController 인스턴스를 생성
        let tempNavController = UINavigationController(rootViewController: appRecommendationTableView)
        tempNavController.modalPresentationStyle = .fullScreen // 풀스크린으로 설정
        present(tempNavController, animated: true, completion: nil)
    }


}


#if DEBUG
import SwiftUI

#Preview{
    MainViewController().toPreview()
}

#endif
