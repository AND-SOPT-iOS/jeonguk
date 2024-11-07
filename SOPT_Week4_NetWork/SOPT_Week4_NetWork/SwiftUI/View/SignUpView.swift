//
//  SignUpView.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/7/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("사용자 이름", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("비밀번호", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("취미", text: $viewModel.hobby)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                viewModel.register()
            }) {
                Text("회원가입")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            
            if viewModel.isRegistered {
                Text("회원가입이 완료되었습니다!")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }
}


#Preview {
    SignUpView()
}
