//
//  CreateUserRequest.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import Foundation

struct CreateUserResponse: Decodable {
    let token: String?
    let user: UserModel?
}

struct CreateUserRequest: Encodable {
    let name: String
    let email: String
    let password: String
}

struct BasicAuthenticationRequest {
    let email: String
    let password: String
    
    var loginString: String {
        String(format: "%@:%@", email, password)
    }
}

struct UserModel: Codable {
    let id: String
    let name: String
    let email: String
    let avatar: String?
}
