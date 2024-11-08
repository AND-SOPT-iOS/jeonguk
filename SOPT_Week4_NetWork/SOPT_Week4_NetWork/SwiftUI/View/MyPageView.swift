//
//  MyPageView.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/8/24.
//

import SwiftUI

struct MyPageView: View {
    @StateObject var viewModel = MyPageViewModel() // 뷰모델 생성
    @State private var successMessage: String? // 성공 메시지 추가
    
    var body: some View {
        VStack {
            TextField("취미 입력", text: $viewModel.hobby)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("비밀번호 입력", text: $viewModel.password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if viewModel.isLoading {
                ProgressView() // 로딩 중이면 ProgressView 표시
            } else {
                Button("취미 수정") {
                    // 취미 수정 요청
                    viewModel.updateUserInformation { result in
                        switch result {
                        case .success:
                            // 성공 처리
                            successMessage = "취미 수정 성공"
                            print("취미 수정 성공")
                        case .failure(let error):
                            // 실패 처리
                            viewModel.errorMessage = error.localizedDescription
                            print("취미 수정 실패: \(error.localizedDescription)")
                        }
                    }
                }
                .padding()
                .disabled(viewModel.isLoading) // 로딩 중에는 버튼 비활성화
                
                // 실패 메시지 표시
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // 성공 메시지 표시
                if let successMessage = successMessage {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .padding()
                }
            }
        }
        .padding()
    }
}


#Preview {
    MyPageView()
}


