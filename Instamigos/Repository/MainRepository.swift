//
//  MainRepository.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import Foundation

class MainRepository {
    
    let network = Network(session: URLSession.shared)
    weak var mainCoordinator: MainCoordinator?
    
    func postUser(data: CreateUserRequest, completion: ((SessionUserResponse?) -> Void)?) {
        network.fetchRequest(urlPath: "/users", requestBody: data, authentication: nil, httpMethod: .post, contentType: .json) { responseData, statusCode in
            let statusCode = StatusCode.getStatusCode(code: statusCode)
            self.mainCoordinator?.showErrorMessage(statusCode: statusCode)
            completion?(responseData)
        }
    }
    
    func loginUser(authentication: BasicAuthenticationModel, completion: ((SessionUserResponse?) -> Void)?) {
        if let loginString = authentication.loginString() {
            network.fetchRequest(urlPath: "/users/login", requestBody: nil, authentication: .basic(loginString: loginString), httpMethod: .post, contentType: nil) { responseData, statusCode in
                let statusCode = StatusCode.getStatusCode(code: statusCode)
                self.mainCoordinator?.showErrorMessage(statusCode: statusCode)
                completion?(responseData)
            }
        }
    }
    
    func postCreatePost(content: String, completion: ((PostResponse?) -> Void)?) {
        if let retriveToken = KeychainManager.shared.retrieveToken() {
            network.fetchRequest(urlPath: "/posts", requestBody: nil, authentication: .bearer(token: retriveToken), httpMethod: .post, contentType: .textPlain(content: content)) { responseData, statusCode in
                let statusCode = StatusCode.getStatusCode(code: statusCode)
                self.mainCoordinator?.showErrorMessage(statusCode: statusCode)
                completion?(responseData)
            }
        }
    }
    
    func getAllPosts(completion: (([PostLikeResponse]?) -> Void)?) {
        network.fetchRequest(urlPath: "/posts", requestBody: nil, authentication: nil, httpMethod: .get, contentType: nil) { responseData, statusCode in
            let statusCode = StatusCode.getStatusCode(code: statusCode)
            self.mainCoordinator?.showErrorMessage(statusCode: statusCode)
            completion?(responseData)
        }
    }
    
    func getUserBy(userId: String, completion: ((UserModel?) -> Void)?) {
        network.fetchRequest(urlPath: "/users/\(userId)", requestBody: nil, authentication: nil, httpMethod: .get, contentType: nil) { responseData, statusCode in
            let statusCode = StatusCode.getStatusCode(code: statusCode)
            self.mainCoordinator?.showErrorMessage(statusCode: statusCode)
            completion?(responseData)
        }
    }
    
    func postUserLogout(completion: ((SessionUserResponse?) -> Void)?) {
        if let retriveToken = KeychainManager.shared.retrieveToken() {
            network.fetchRequest(urlPath: "/users/logout", requestBody: nil, authentication: .bearer(token: retriveToken), httpMethod: .post, contentType: nil) { responseData, statusCode in
                let statusCode = StatusCode.getStatusCode(code: statusCode)
                self.mainCoordinator?.showErrorMessage(statusCode: statusCode)
                completion?(responseData)
            }
        }
    }
}
