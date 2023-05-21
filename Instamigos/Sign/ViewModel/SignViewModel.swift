//
//  SignViewModel.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import Foundation

class SignViewModel {
    
    let mainRepository = MainRepository()
    
    func postUser(name: String, email: String, password: String) {
        let data = CreateUserRequest(name: name, email: email, password: password)
        mainRepository.postUser(data: data)
    }
    
    func loginUser(email: String, password: String, completion: (() -> Void)?) {
        let authentication = BasicAuthenticationModel(email: email, password: password)
        mainRepository.loginUser(authentication: authentication) { responseData in
            if let token = responseData.token {
                KeychainManager.shared.saveToken(token: token)
                completion?()
            }
        }
    }
}
