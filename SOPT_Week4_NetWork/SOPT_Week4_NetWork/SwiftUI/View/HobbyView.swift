//
//  HobbyView.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import SwiftUI

struct HobbyView: View {
    @StateObject private var viewModel = HobbyViewModel()
    @State private var otherUserID: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("취미 조회")
                .font(.largeTitle)
                .padding()
            
            // 내 취미 조회
            Button(action: {
                viewModel.fetchMyHobby()
            }) {
                Text("내 취미 조회")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            // 내 취미 결과
            if !viewModel.myHobby.isEmpty {
                Text("내 취미: \(viewModel.myHobby)")
                    .padding()
            }
            
            // 다른 유저 취미 조회
            TextField("다른 유저 ID", text: $otherUserID)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                viewModel.fetchOtherUserHobby(userID: otherUserID)
            }) {
                Text("다른 유저의 취미 조회")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            // 다른 유저 취미 결과
            if !viewModel.otherUserHobby.isEmpty {
                Text("다른 유저의 취미: \(viewModel.otherUserHobby)")
                    .padding()
            }
            
            // 로딩 중인 경우 ProgressView 표시
            if viewModel.isLoading {
                ProgressView()
            }
            
            // 에러 메시지 표시
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    HobbyView()
}
