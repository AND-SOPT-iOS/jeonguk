//
//  HobbyViewModel.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/7/24.
//

import Foundation
import Combine

final class HobbyViewModel: ObservableObject {
    @Published var myHobby: String = ""
    @Published var otherUserHobby: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    
    // 내 취미 조회
    func fetchMyHobby() {
        isLoading = true
        errorMessage = nil
        UserService.shared.fetchUserHobby { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let hobby):
                    self?.myHobby = hobby
                case .failure(let error):
                    self?.errorMessage = "취미를 가져오는데 실패했습니다: \(error.localizedDescription)"
                }
            }
        }
    }
    
    // 다른 유저 취미 조회
    func fetchOtherUserHobby(userID: String) {
        isLoading = true
        errorMessage = nil
        UserService.shared.fetchOtherUserHobby(userID: userID) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let hobby):
                    self?.otherUserHobby = hobby
                case .failure(let error):
                    self?.errorMessage = "다른 유저의 취미를 가져오는데 실패했습니다: \(error.localizedDescription)"
                }
            }
        }
    }
}
