//
//  MainCoordinator.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import UIKit

class MainCoordinator {
    var navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        callFeedViewController()
        
        /*
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: "SignViewController")
         navigationController.pushViewController(viewController, animated: true)
         */
   
    }
    
    func callFeedViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController")
        navigationController.pushViewController(viewController, animated: true)
    }
}
