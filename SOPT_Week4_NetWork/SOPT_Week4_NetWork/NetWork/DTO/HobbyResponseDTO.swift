//
//  HobbyResponseDTO.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/7/24.
//

import Foundation

// 성공 응답에서 hobby 값을 담을 구조체
struct HobbyResponse: Decodable {
    let result: HobbyResult
}

// hobby 값을 담을 구조체
struct HobbyResult: Decodable {
    let hobby: String
}

