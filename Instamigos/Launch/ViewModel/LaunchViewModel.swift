//
//  LaunchViewModel.swift
//  Instamigos
//
//  Created by Cáren Sousa on 24/05/23.
//

import Foundation

class LaunchViewModel {
    
    weak var mainRepository: MainRepository?
    
    func getCurrentAuthenticatedUser(completion: ((UserModel?) -> Void)?) {
        mainRepository?.getCurrentAuthenticatedUser() { responseData in
            completion?(responseData)
        }
    }
}
