//
//  UserService.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import Foundation
import Alamofire

/// 클래스는 라우터 별로 나눠줄 수 있음!
/// 라우터란 URL의 분기점. 이 클래스의 분기점은 /user 임
final class UserService {
    
    // Singleton instance
    static let shared = UserService()
    private init() {}
    
    
    // MARK: 유저 등록
    /// 등록 API 콜이 일어나는 메소드
    /// 파라미터는 Request Body에 필요한 것들
    func register(
        username: String,
        password: String,
        hobby: String,
        completion: @escaping (Result<Bool, NetworkError>) -> Void
    ) {
        
        /// baseURL + /user = http://211.188.53.75:8080/user
        let url = Environment.baseURL + "/user"
        
        /// 파라미터는 Request Body,
        /// HTTP 요청에서 전송되는 데이터를 일반적으로 "parameters" 또는 "params"라고 부름.
        /// GET 요청의 쿼리 파라미터나 POST 요청의 바디 데이터 모두 "parameters"로 통일해서 부름
        let parameters = RegisterRequest(
            username: username,
            password: password,
            hobby: hobby
        )
        
        /// Request시 url, method, parameters, 인코딩 방식을 파라미터로 넘겨주어야 함.
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .response { [weak self] response in
            
            /// 다양한 정보가 넘어오게 되는데, 우리에게 중요한 것은 보통 statusCode와 data임
            /// self를 해준 이유는 클래스 내의 다른 함수에 접근해야 하고 response가 escaping closure이기 때문
            guard let statusCode = response.response?.statusCode,
                  let data = response.data,
                  let self
            else {
                completion(.failure(.unknownError))
                return
            }
            
            /// public let result: Result<Success, Failure>
            /// Alamofire의 data response에는 result 프로퍼티가 존재하는데, 해당 프로퍼티는 Result<Success, Failure> 타입임!
            /// 이 말은, 타입이 다른 함수에서 리턴되어 넘어갈 때, success로 넘어갈 수 있고 failure로 넘어갈 수 있다는 것
            /// 그리고 그 안에는 우리가 원하는 결과값들이 존재한다.
            /// Result<Bool, NetworkError>
            /// Success 하면 Bool 값을, Failure 하면 NetworkError를 리턴하겠다는 뜻
            /// Success에는 원하는 타입이 올 수 있고, Failure에는 Error 프로토콜이 채택된 것이 리턴될 수 있도록 되어야 함
            switch response.result {
            case .success:
                /// 네트워크 요청이 성공적으로 진행되었을 때, escaping closure을 실행하고 bool값을 success로 넘김.
                completion(.success(true))
            case .failure:
                /// 네트워크 요청이 실패했을 때, 어떤 이유인지 파악하여 escaping closure을 실행하고 파악된 error를 넘김
                let error = self.handleStatusCode(statusCode, data: data)
                completion(.failure(error))
            }
        }
    }
    // 💁 받는쪽에서 Result 타입이면 성공 실패 분기 처리해서 사용하면 됨
    
    // MARK: 유저 로그인
    func Login(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponse, NetworkError>) -> Void // Bool 대신 String 반환
    ) {
        let url = Environment.baseURL + "/login"
        
        let parameters = LoginRequest(
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
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
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
            "Authorization": "Bearer \(token)"
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
                    let hobbyResponse = try JSONDecoder().decode(HobbyResponse.self, from: data)
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
        // UserDefaults에서 토큰을 가져오기
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
                    let hobbyResponse = try JSONDecoder().decode(HobbyResponse.self, from: data)
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
        // UserDefaults에서 토큰을 가져오기
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            completion(.failure(.unknownError))
            return
        }
        
        // URL 정의
        let url = "\(Environment.baseURL)/user"
        
        // 요청 헤더에 token 추가
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": token
        ]
        
        // 요청 본문 데이터
        let parameters: [String: String] = [
            "hobby": hobby,
            "password": password
        ]
        
        // PUT 요청 보내기
        AF.request(
            url,
            method: .put,
            parameters: parameters,
            encoding: JSONEncoding.default,
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
                // 성공 시 결과 반환
                completion(.success(()))
                
            case .failure:
                // 상태 코드에 따른 에러 처리
                let error = self.handleStatusCode(statusCode, data: data)
                completion(.failure(error))
            }
        }
    }


    
    
    /// 서버의 명세서 기반으로 에러 처리를 진행해줌
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
    
    // 서버에서 오는 JSON 변환
    func decodeError(data: Data) -> String {
        guard let errorResponse = try? JSONDecoder().decode(
            ErrorResponse.self,
            from: data
        ) else { return "" }
        return errorResponse.code
    }
}
