//
//  Encodable+Dictionary.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/12/24.
//

import Foundation

extension Encodable {

    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        ) as? [String: Any] else {
            throw RouterError.encoding
        }
        return dictionary
    }

}
