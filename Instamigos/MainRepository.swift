//
//  MainRepository.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import Foundation

class MainRepository {
    
    let network = Network()
    
    func getUser(data: CreateUserRequest) {
        network.fetchRequest(requestBody: data)
    }
}
