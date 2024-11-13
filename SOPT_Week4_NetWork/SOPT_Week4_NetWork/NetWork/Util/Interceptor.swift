//
//  Interceptor.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/13/24.
//

import Foundation

import Alamofire

final class Interceptor: RequestInterceptor {
    
    private let keyChainManager: KeyChainManager
    
    init(keyChainManager: KeyChainManager) {
        self.keyChainManager = keyChainManager
    }
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (
            Result<URLRequest, any Error>
        ) -> Void
    ) {
        guard let token = keyChainManager.searchValue() else {
            completion(.failure(InterceptorError.loadTokenFailed))
            return
        }
        var urlRequest = urlRequest
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        completion(.success(urlRequest))
    }
    
}
