//
//  Router.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/12/24.
//

import Alamofire
import Foundation

protocol Router: URLRequestConvertible {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding? { get }
    
}

extension Router {
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw RouterError.invalidURL
        }
        var request = URLRequest(url: url)
        
        request.method = method
        request.headers = HTTPHeaders(headers)
        
        if let encoding = encoding {
            if let parameters = parameters {
                return try encoding.encode(request, with: parameters)
            } else {
                throw RouterError.encoding
            }
        }
        
        return request
    }
    
}
