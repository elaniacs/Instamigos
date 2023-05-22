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
        network.fetchRequest(urlPath: "/users", requestBody: data, authentication: nil, httpMethod: .post, contentType: .json) { (_: SessionUserResponse) in }
    }
    
    func loginUser(authentication: BasicAuthenticationModel, completion: ((SessionUserResponse) -> Void)?) {
        if let loginString = authentication.loginString() {
            network.fetchRequest(urlPath: "/users/login", requestBody: nil, authentication: .basic(loginString: loginString), httpMethod: .post, contentType: nil) { responseData in
                completion?(responseData)
            }
        }
    }
    
    func postCreatePost(content: String, completion: (() -> Void)?) {
        if let retriveToken = KeychainManager.shared.retrieveToken() {
            network.fetchRequest(urlPath: "/posts", requestBody: nil, authentication: .bearer(token: retriveToken), httpMethod: .post, contentType: .textPlain(content: content)) { (_: PostResponse) in
                completion?()
            }
        }
    }
    
    func getAllPosts(completion: (([PostLikeResponse]) -> Void)?) {
        network.fetchRequest(urlPath: "/posts", requestBody: nil, authentication: nil, httpMethod: .get, contentType: nil) { responseData in
            completion?(responseData)
        }
    }
    
    func getUserBy(userId: String, completion: ((UserModel) -> Void)?) {
        network.fetchRequest(urlPath: "/users/\(userId)", requestBody: nil, authentication: nil, httpMethod: .get, contentType: nil) { responseData in
            completion?(responseData)
        }
    }
}
