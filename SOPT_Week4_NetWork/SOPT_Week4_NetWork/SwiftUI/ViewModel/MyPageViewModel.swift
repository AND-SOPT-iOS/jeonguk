//
//  MyPageViewModel.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/8/24.
//

import Foundation

final class MyPageViewModel: ObservableObject {
    
    // MARK: - State Properties
    
    @Published var hobby: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    private let apiService: APIService
    
    // MARK: - Initializer
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    // MARK: - Methods
    
    func updateUserInformation(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        isLoading = true
        errorMessage = nil
        
        apiService.putMyHobby(hobby: hobby, password: password){ [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    self?.errorMessage = "정보 업데이트에 실패했습니다: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        apiService.logout { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
        }
    }

}
