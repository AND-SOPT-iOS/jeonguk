//
//  HomeView.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/8/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        // 3번 - 혼합
        ScrollView(.vertical, showsIndicators: true) {
            
            HStack{
                Text("오늘 다른 사람들의 취미 활동")
                    .font(.title2)
                Spacer()
            }
            .padding(.leading)
            
            LazyVStack {
                // 세로 스크롤 항목
                ForEach(0..<10) { index in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0..<10) { _ in
                                AsyncImageBasic(index: index) // 랜덤 이미지를 비동기적으로 로드
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
}

struct AsyncImageBasic: View {
    // property
    let url: URL?
    
    init(index: Int) {
        // 각 카드에 고유한 이미지를 가져오기 위한 URL 설정 (예시로 Picsum 사진 사용)
        self.url = URL(string: "https://picsum.photos/200?random=\(index)")
    }
    
    var body: some View {
        VStack {
            // AsyncImage 사용하여 이미지 로드
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView() 
            }
            .padding(.bottom, 5)
            
        }
        .padding()
    }
}


#Preview {
    HomeView()
}
