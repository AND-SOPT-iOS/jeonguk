//
//  Environment.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//
import Foundation

enum Environment {
  static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}
