//
//  SignUpViewModel.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/7/24.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    // MARK: - State Properties
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var hobby: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isRegistered: Bool = false
    
    
    
    // MARK: - Methods
    func register() {
  
        guard !username.isEmpty, !password.isEmpty, !hobby.isEmpty else {
            errorMessage = "모든 필드를 입력해주세요."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        UserService.shared.register(
            username: username,
            password: password,
            hobby: hobby ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success:
                    self.isRegistered = true
                case .failure(let error):
                    self.errorMessage = "회원가입에 실패했습니다: \(error.localizedDescription)"
                }
            }
        }
    }
}
