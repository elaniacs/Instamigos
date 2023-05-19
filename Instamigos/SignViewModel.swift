//
//  SignViewModel.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import Foundation

class SignViewModel {
    
    let mainRepository = MainRepository()
    
    func getUser(name: String, email: String, password: String) {
        let data = CreateUserRequest(name: name, email: email, password: password)
        mainRepository.getUser(data: data)
    }
}
