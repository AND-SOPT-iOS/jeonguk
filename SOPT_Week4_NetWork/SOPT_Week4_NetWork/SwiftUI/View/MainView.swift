//
//  MainView.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import SwiftUI

struct MainView: View {

    
    var body: some View {
 
        TabView() {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
            
            HobbyView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("취미 검색")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("마이 페이지")
                }
        }
        .accentColor(.red)
    }
}

#Preview {
    MainView()
        .previewDevice("iPhone 14")  
}
