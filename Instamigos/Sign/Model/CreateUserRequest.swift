//
//  CreateUserRequest.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import Foundation

struct SessionUserResponse: Decodable {
    let token: String?
    let user: UserModel?
}

struct CreateUserRequest: Encodable {
    let name: String
    let email: String
    let password: String
}

struct BasicAuthenticationModel {
    let email: String
    let password: String
    
    func loginString() -> String? {
        let loginString = String(format: "%@:%@", email, password)
        
        if let loginStringData = loginString.data(using: .utf8) {
            let base64LoginString = loginStringData.base64EncodedString()
            return base64LoginString
        }
        return nil
    }
}

struct UserModel: Codable {
    let id: String
    let name: String
    let email: String
    let avatar: String?
}
