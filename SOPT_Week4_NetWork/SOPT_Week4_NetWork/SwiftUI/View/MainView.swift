//
//  MainView.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import SwiftUI

struct MainView: View {

    
    var body: some View {
        // selection: TabView 가 어디 페이지를 가리키는지 설정하는것
        TabView() {
            HobbyView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("MyPage")
                }
        }
        .accentColor(.red)
    }
}

#Preview {
    MainView()
        .previewDevice("iPhone 14")  // Specify a device for the preview
}
