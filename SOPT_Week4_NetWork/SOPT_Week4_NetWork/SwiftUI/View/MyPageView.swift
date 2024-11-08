//
//  MyPageView.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/8/24.
//

import SwiftUI

struct MyPageView: View {
    @StateObject var viewModel = MyPageViewModel()
    @State private var successMessage: String?
    @SwiftUI.Environment(\.dismiss) var dismiss // 화면을 닫기 위한 dismiss 프로퍼티
    
    var body: some View {
        VStack {
            // 취미 입력 필드
            TextField("취미 입력", text: $viewModel.hobby)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // 비밀번호 입력 필드
            SecureField("비밀번호 입력", text: $viewModel.password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button(action: {
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
                }) {
                    Text("취미 수정")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(viewModel.isLoading) // 로딩 중에는 버튼 비활성화
            }
            
            
            
            
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
            
            Button(action: {
                viewModel.logout { result in
                    switch result {
                    case .success:
                        // 로그아웃 후 네비게이션으로 뒤로 가기
                        successMessage = "로그아웃 성공"
                        dismiss() // 현재 뷰 닫기
                    case .failure(let error):
                        print("로그아웃 실패: \(error.localizedDescription)")
                    }
                }
            }) {
                Text("로그아웃")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            
        }
        .padding()
    }
}

#Preview {
    MyPageView()
}


