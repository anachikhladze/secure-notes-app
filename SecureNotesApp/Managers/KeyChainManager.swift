//
//  KeyChainManager.swift
//  SecureNotesApp
//
//  Created by Anna Sumire on 06.11.23.
//

import Foundation
import Security

class KeyChainManager {
    
    static let shared = KeyChainManager()
    
    private let service = "SecureNotesApp"
    
    enum KeyChainError : Error {
        case sameItemFound
        case unknown
        case nosuchDataFound
        case KCErrorWithCode(Int)
    }
    
    // MARK: - Save
    func saveCredentials(username: String, password: String) throws {
        
        guard let passwordData = password.data(using: .utf8) else {
            throw KeyChainError.unknown
        }
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: username as AnyObject,
            kSecValueData as String: passwordData as AnyObject,
        ]
        
        let saveStatus = SecItemAdd(query as CFDictionary, nil)
        
        guard saveStatus != errSecDuplicateItem else {
            throw KeyChainError.sameItemFound
        }
        
        guard saveStatus == errSecSuccess else {
            throw KeyChainError.unknown
        }
        
        print("Username And Password Saved Successfully")
    }
    
    // MARK: - Retrieve Password
    func retrievePassword(username: String)-> String? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecReturnData as String: kCFBooleanTrue as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess, let passwordData = result as? Data else {
            return nil
        }
        return String(data: passwordData, encoding: .utf8)
    }
    
    // MARK: - Remove Credentials
    func remove(username: String) throws {
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: username as AnyObject
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeyChainError.KCErrorWithCode(Int(status))
        }
    }
}
