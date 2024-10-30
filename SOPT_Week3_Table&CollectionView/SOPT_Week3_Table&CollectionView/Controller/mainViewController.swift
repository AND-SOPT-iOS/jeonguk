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
    
    lazy var titlelable = UILabel().then {
        $0.text = "iPhone 필수 앱"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    
    lazy var imageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var dscLable = UILabel().then {
        $0.text = "에디터가 직접 고른 추천 앱으로 시작하세요"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerView = AppRecommendationHeaderView()
        headerView.configure(title: "iPhone 필수 앱", description: "에디터가 직접 고른 추천 앱으로 시작하세요")
   
        let headerView2 = AppRecommendationHeaderView()
        headerView2.configure(title: "지금 주목해야 할 앱", description: "새로 나온 앱과 업데이트")
        // headerView를 원하는 곳에 추가

        let appRecommendationView1 = AppRecommendationView()
        let appRecommendationView2 = AppRecommendationView()
        
        view.addSubview(headerView)
        view.addSubview(headerView2)
        view.addSubview(appRecommendationView1)
        view.addSubview(appRecommendationView2)
        
        // 레이아웃 설정
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
        }
    }
}


#if DEBUG
import SwiftUI

#Preview{
    MainViewController().toPreview()
}

#endif
