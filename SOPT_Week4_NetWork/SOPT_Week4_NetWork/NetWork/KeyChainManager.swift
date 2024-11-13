//
//  KeyChainManager.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/13/24.
//

import Foundation

import Security

protocol KeyChainManager: Sendable {
    
    func saveValue(token: String) -> OSStatus
    func updateValue(token: String) -> OSStatus
    func searchValue() -> String?
    @discardableResult
    func removeValue() -> OSStatus
    
}

final class DefaultKeyChainManager: KeyChainManager {
    
    private let serviceName: String = "SOPT_Woogie"
    
    func saveValue(token: String) -> OSStatus {
        let saveData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecReturnData: true,
            kSecValueData: token.data(using: .utf8)!
        ] as CFDictionary
        let status = SecItemAdd(saveData, nil)
        handleStatus(status: status)
        return status
    }
    
    func updateValue(token: String) -> OSStatus {
        let savedData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName
        ] as CFDictionary
        
        let updateData: CFDictionary = [
            kSecValueData: token.data(using: .utf8)!
        ] as CFDictionary
        return SecItemUpdate(savedData, updateData)
    }
    
    func searchValue() -> String? {
        let savedData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecReturnData: true
        ] as CFDictionary
        var searchWord:CFTypeRef? = nil
        let searchResult = SecItemCopyMatching(savedData, &searchWord)
        if searchResult != errSecSuccess {
            return nil
        }
        let searchData: Data = searchWord as! Data
        return String(data: searchData, encoding: .utf8)
    }
    
    @discardableResult
    func removeValue() -> OSStatus {
        let savedData: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecReturnData: true
        ] as CFDictionary
        return SecItemDelete(savedData)
    }
    
    private func handleStatus(status: OSStatus) {
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            print("duplicated")
        default:
            print("default")
        }
    }
    
}

struct MockKeyChainManager: KeyChainManager {
    func saveValue(token: String) -> OSStatus { return errSecSuccess }
    func updateValue(token: String) -> OSStatus { return errSecSuccess }
    func searchValue() -> String? { return "MockToken" }
    @discardableResult
    func removeValue() -> OSStatus { return errSecSuccess }
}
