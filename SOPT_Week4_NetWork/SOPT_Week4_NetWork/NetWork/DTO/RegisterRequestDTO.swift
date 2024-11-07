//
//  RegisterRequestDTO.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import Foundation

struct RegisterRequest: Codable {
  let username: String
  let password: String
  let hobby: String
}


struct LoginRequest: Codable {
  let username: String
  let password: String
}

struct LoginResponse: Codable {
    let result: Token
}

struct Token: Codable {
    let token: String
}
