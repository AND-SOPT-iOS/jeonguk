//
//  AppSample.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/30/24.
//

import UIKit


struct App {
    let iconImage: UIImage
    let ThumbnailImages: [UIImage]
    let ranking: Int
    let title: String
    let subTitle: String
    let category: String
    let downloadState: DownloadState
    
    
}

enum DownloadState {
    case installed
    case download
    case redownload
    case update
    
    var title: String {
        switch self {
        case .installed: return "Open"
        case .download: return "Download"
        case .redownload: return "Redownload"
        case .update: return "Update"
        }
    }
    
    
}

extension App {
    
    // Mock data generation
    static let apps: [App] = generateMockApps()

    static func generateMockApps() -> [App] {
        // Default sample images (use different ones for 토스 below)
        let sampleIconImage = UIImage(systemName: "app.fill")!
        let sampleThumbnailImages = [UIImage(systemName: "photo")!, UIImage(systemName: "photo")!]

        // App-specific images for "토스"
        let tossIconImage = UIImage(named: "toss") ?? sampleIconImage
        let tossThumbnailImages = [UIImage(named: "banner") ?? sampleThumbnailImages[0], UIImage(named: "banner") ?? sampleThumbnailImages[1]]

        // Korean app store style data
        let appTitles = [
            "네이버 지도", "카카오톡", "배달의민족", "토스", "무신사 스토어",
            "쿠팡", "멜론", "오늘의집", "당근마켓", "네이버 웨일",
            "왓챠", "리디북스", "네이버 페이", "야놀자", "여기어때",
            "마이 캘린더", "인프런", "번개장터", "카카오 T", "직방"
        ]

        let subtitles = [
            "길 찾기부터 주변 정보까지", "친구와 대화하고 소통해요", "음식 배달의 모든 것",
            "간편한 금융 생활", "최신 패션을 한눈에", "빠르고 신선한 쇼핑",
            "음악 스트리밍의 기준", "내 집 꾸미기 아이디어", "동네 중고 거래 앱",
            "쉽고 빠른 웹 브라우저", "영화와 드라마 추천", "다양한 전자책",
            "쉽고 안전한 결제", "숙박 예약의 새로운 경험", "편리한 숙소 예약",
            "일정을 손쉽게 관리해요", "온라인 강의와 학습", "중고 거래를 쉽게",
            "택시와 대중교통 서비스", "내 집 찾기 앱"
        ]

        let categories = [
            "지도 및 내비게이션", "소셜 네트워킹", "음식 및 음료", "금융", "쇼핑",
            "쇼핑", "음악", "라이프 스타일", "쇼핑", "유틸리티",
            "엔터테인먼트", "도서", "금융", "여행", "여행",
            "생산성", "교육", "쇼핑", "여행", "라이프 스타일"
        ]

        let downloadStates: [DownloadState] = [.installed, .download, .redownload, .update]

        // Generate mock data
        var mockApps: [App] = []

        for i in 0..<20 {
            let app = App(
                iconImage: appTitles[i] == "토스" ? tossIconImage : sampleIconImage,
                ThumbnailImages: appTitles[i] == "토스" ? tossThumbnailImages : sampleThumbnailImages,
                ranking: i + 1,
                title: appTitles[i],
                subTitle: subtitles[i],
                category: categories[i],
                downloadState: downloadStates.randomElement()!
            )
            mockApps.append(app)
        }

        return mockApps
    }
}
