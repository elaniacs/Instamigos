//
//  SignViewModel.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import Foundation

class SignViewModel {
    
    let mainRepository = MainRepository()
    
    func postUser(name: String, email: String, password: String, completion: (() -> Void)?) {
        let data = CreateUserRequest(name: name, email: email, password: password)
        mainRepository.postUser(data: data) { responseData in
            
            self.saveUserDefaults(name: responseData.user?.name, email: responseData.user?.email)
            
            if let token = responseData.token {
                KeychainManager.shared.saveToken(token: token)
            }
            completion?()
        }
    }
    
    func loginUser(email: String, password: String, completion: (() -> Void)?) {
        let authentication = BasicAuthenticationModel(email: email, password: password)
        mainRepository.loginUser(authentication: authentication) { responseData in
            
            self.saveUserDefaults(name: responseData.user?.name, email: responseData.user?.email)
            
            if let token = responseData.token {
                KeychainManager.shared.saveToken(token: token)
            }
            completion?()
        }
    }
    
    func saveUserDefaults(name: String?, email: String?) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "UserName")
        defaults.set(email, forKey: "UserEmail")
        defaults.synchronize()
    }
    
    func validateFields(name: String?, email: String?, password: String?, confirmPassword: String?, completion: ((String) -> Void)) -> Bool {
        
        guard let name = name, !name.isEmpty else {
            completion("Please, enter your name")
            return false
        }
        
        guard let email = email, !email.isEmpty else {
            completion("Please, enter your e-mail.")
            return false
        }
        
        guard let password = password, !password.isEmpty else {
            completion("Please enter the password.")
            return false
        }
        
        guard let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {
            completion("Please confirm the password.")
            return false
        }
        
        if name.count < 3 {
            completion("The name must be at least 3 characters long.")
            return false
        }
        
        if !isValidEmail(email) {
            completion("Please enter a valid email address.")
            return false
        }
        
        if password != confirmPassword {
            completion( "The passwords do not match.")
            return false
        }
        
        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
