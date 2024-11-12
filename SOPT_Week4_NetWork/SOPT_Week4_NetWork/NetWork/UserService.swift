//
//  UserService.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import Foundation
import Alamofire

final class UserService {
    
    static let shared = UserService()
    private init() {}
    
    // MARK: 유저 등록
    func register(
        username: String,
        password: String,
        hobby: String,
        completion: @escaping (Result<Bool, NetworkError>) -> Void
    ) {
        
        let url = Environment.baseURL + "/user"
        let parameters = RegisterRequestDTO(
            username: username,
            password: password,
            hobby: hobby
        )
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .response { [weak self] response in
            
            guard let statusCode = response.response?.statusCode,
                  let data = response.data,
                  let self
            else {
                completion(.failure(.unknownError))
                return
            }
            
            switch response.result {
            case .success:
                completion(.success(true))
            case .failure:
                let error = self.handleStatusCode(statusCode, data: data)
                completion(.failure(error))
            }
        }
    }
    
    // MARK: 유저 로그인
    func Login(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponseDTO, NetworkError>) -> Void
    ) {
        let url = Environment.baseURL + "/login"
        
        let parameters = LoginRequestDTO(
            username: username,
            password: password
        )
        
        // 요청 헤더 설정
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers // 헤더 추가
        )
        .validate()
        .response { [weak self] response in
            guard let statusCode = response.response?.statusCode,
                  let data = response.data,
                  let self
            else {
                completion(.failure(.unknownError))
                return
            }
            
            switch response.result {
            case .success:
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponseDTO.self, from: data)
                    completion(.success(loginResponse))
                } catch {
                    completion(.failure(.unknownError))
                }
                
            case .failure:
                let error = self.handleStatusCode(statusCode, data: data)
                completion(.failure(error))
            }
        }
    }
    
    // MARK: 내 취미 조회
    func fetchUserHobby(completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            completion(.failure(.unknownError))
            return
        }
        
        let url = Environment.baseURL + "/user/my-hobby"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": token
        ]
        
        AF.request(
            url,
            method: .get,
            headers: headers
        )
        .validate() // 상태 코드 유효성 검사
        .response { [weak self] response in
            guard let statusCode = response.response?.statusCode, let data = response.data, let self else {
                completion(.failure(.unknownError))
                return
            }
            
            switch response.result {
            case .success:
                do {
                    let hobbyResponse = try JSONDecoder().decode(HobbyResponseDTO.self, from: data)
                    completion(.success(hobbyResponse.result.hobby))
                } catch {
                    completion(.failure(.unknownError))
                }
                
            case .failure:
                let error = self.handleStatusCode(statusCode, data: data)
                completion(.failure(error))
            }
        }
    }
    
    // MARK: 다른 사람 취미 조회
    func fetchOtherUserHobby(userID: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            completion(.failure(.unknownError))
            return
        }
        
        let url = "\(Environment.baseURL)/user/\(userID)/hobby"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": token
        ]
        
        AF.request(
            url,
            method: .get,
            headers: headers
        )
        .validate()
        .response { [weak self] response in
            guard let statusCode = response.response?.statusCode, let data = response.data, let self else {
                completion(.failure(.unknownError))
                return
            }
            
            switch response.result {
            case .success:
                do {
                    let hobbyResponse = try JSONDecoder().decode(HobbyResponseDTO.self, from: data)
                    completion(.success(hobbyResponse.result.hobby))
                } catch {
                    completion(.failure(.unknownError))
                }
                
            case .failure:
                let error = self.handleStatusCode(statusCode, data: data)
                completion(.failure(error))
            }
        }
    }
    
    // MARK: 취미 변경
    func updateUserInformation(hobby: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            completion(.failure(.unknownError))
            return
        }
        
        let url = "\(Environment.baseURL)/user"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": token
        ]
        
        let parameters: [String: Any] = [
            "hobby": hobby,
            "password": password
        ]
        
        AF.request(
            url,
            method: .put,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate()
        .response { [weak self] response in
            guard let self = self else {
                completion(.failure(.unknownError))
                return
            }
            
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(.unknownError))
                return
            }
            
            switch response.result {
            case .success:
                completion(.success(()))
                
            case .failure:
                if let data = response.data {
                    let error = self.handleStatusCode(statusCode, data: data)
                    completion(.failure(error))
                } else {
                    completion(.failure(.unknownError))
                }
            }
        }
    }
    
    // MARK: 로그아웃
    func logout(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        if UserDefaults.standard.string(forKey: "userToken") != nil {
            UserDefaults.standard.removeObject(forKey: "userToken")
            completion(.success(()))
        } else {
            completion(.failure(.unknownError))
        }
    }
    
    func handleStatusCode(
        _ statusCode: Int,
        data: Data
    ) -> NetworkError {
        let errorCode = decodeError(data: data)
        switch (statusCode, errorCode) {
        case (400, "00"):
            return .invalidRequest
        case (400, "01"):
            return .expressionError
        case (404, ""):
            return .invalidURL
        case (409, "00"):
            return .duplicateError
        case (500, ""):
            return .serverError
        default:
            return .unknownError
        }
    }
    
    func decodeError(data: Data) -> String {
        guard let errorResponse = try? JSONDecoder().decode(
            ErrorResponse.self,
            from: data
        ) else { return "" }
        return errorResponse.code
    }
}
