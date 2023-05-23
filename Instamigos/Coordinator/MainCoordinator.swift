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
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "SignViewController") as? SignViewController {
            viewController.mainCoordinator = self
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func callFeedViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        DispatchQueue.main.async {
            if let viewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController {
                viewController.mainCoordinator = self
                self.navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func callPostViewController() {
        let currentViewController = navigationController.topViewController as? FeedViewController
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController {
            viewController.mainCoordinator = self
            viewController.afterDismiss = currentViewController?.reloadData
            currentViewController?.present(viewController, animated: true)
        }
    }
    
    func backToSign() {
        DispatchQueue.main.async {
            self.navigationController.popToRootViewController(animated: true)
        }
    }
    
    func showAlert(viewController: UIViewController, message: String, handler: ((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
