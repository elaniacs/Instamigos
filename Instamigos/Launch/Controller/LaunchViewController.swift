//
//  LaunchViewController.swift
//  Instamigos
//
//  Created by Cáren Sousa on 24/05/23.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var launchViewModel: LaunchViewModel?
    var mainCoordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticLoginIfNeeded()
    }
    
    func automaticLoginIfNeeded() {
        if KeychainManager.shared.retrieveToken() == nil {
            self.mainCoordinator?.callSignViewController()
            return
        }

        launchViewModel?.getCurrentAuthenticatedUser() { responseData in
            let name = UserDefaults.standard.string(forKey: "UserName")
            let email = UserDefaults.standard.string(forKey: "UserEmail")
            UserDefaults.standard.synchronize()
            
            if let responseData = responseData, responseData.name == name && responseData.email == email {
                self.mainCoordinator?.callFeedViewController()
            } else {
                self.mainCoordinator?.callSignViewController()
            }
        }
    }
}
