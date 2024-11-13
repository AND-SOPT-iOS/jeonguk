//
//  LoginRequest.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/12/24.
//

import Foundation

struct LoginRequestDTO: Codable {
  let username: String
  let password: String
}
