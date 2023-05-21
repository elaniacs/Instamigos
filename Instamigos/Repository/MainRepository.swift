//
//  MainRepository.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import Foundation

class MainRepository {
    
    let network = Network()
    
    func postUser(data: CreateUserRequest) {
        network.fetchRequest(urlPath: "/users", requestBody: data, authentication: nil, httpMethod: .post, contentType: .json, completion: nil)
    }
    
    func loginUser(authentication: BasicAuthenticationModel, completion: ((_ responseData: SessionUserResponse) -> Void)?) {
        if let loginString = authentication.loginString() {
            network.fetchRequest(urlPath: "/users/login", requestBody: nil, authentication: .basic(loginString: loginString), httpMethod: .post, contentType: nil) { responseData in
                completion?(responseData)
            }
        }
    }
    
    func postCreatePost(content: String) {
        if let retriveToken = KeychainManager.shared.retrieveToken() {
            network.fetchRequest(urlPath: "/posts", requestBody: nil, authentication: .bearer(token: retriveToken), httpMethod: .post, contentType: .textPlain(content: content), completion: nil)
        }
    }
}
