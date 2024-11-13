//
//  HobbyViewModel.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/7/24.
//

import Foundation

final class HobbyViewModel: ObservableObject {
    
    // MARK: - State Properties
    
    @Published var myHobby: String = ""
    @Published var otherUserHobby: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private let apiService: APIService
    
    // MARK: - Initializer
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    // MARK: - Methods
    
    func fetchMyHobby() {
        isLoading = true
        errorMessage = nil
        apiService.fetchMyHobby{ [weak self] result in
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
    
//    func fetchOtherUserHobby(userID: String) {
//        isLoading = true
//        errorMessage = nil
//        apiService.fetchOtherUserHobby(userID: userID) { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                switch result {
//                case .success(let hobby):
//                    self?.otherUserHobby = hobby
//                case .failure(let error):
//                    self?.errorMessage = "다른 유저의 취미를 가져오는데 실패했습니다: \(error.localizedDescription)"
//                }
//            }
//        }
//    }
}
