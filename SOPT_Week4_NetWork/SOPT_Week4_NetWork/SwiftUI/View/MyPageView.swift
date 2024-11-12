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
    @SwiftUI.Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("취미 입력", text: $viewModel.hobby)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("비밀번호 입력", text: $viewModel.password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button(action: {
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
                .disabled(viewModel.isLoading)
            }
            
            // 실패 성공 유무 메시지
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
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
