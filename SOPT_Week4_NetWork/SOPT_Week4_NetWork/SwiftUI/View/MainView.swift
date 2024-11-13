//
//  MainView.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import SwiftUI

struct MainView: View {
    
    private let apiService: APIService

    // 생성자에서 apiService를 주입받도록 설정
    init(apiService: APIService) {
        self.apiService = apiService
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
            
            HobbyView(apiService: apiService)
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("취미 검색")
                }
            
            MyPageView(apiService: apiService)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("마이 페이지")
                }
        }
        .accentColor(.red)
    }
}

#Preview {
    MainView(apiService: APIService(keyChainManager: DefaultKeyChainManager()))
        .previewDevice("iPhone 14")
}


