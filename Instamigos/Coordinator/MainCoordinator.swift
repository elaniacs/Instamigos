//
//  MainCoordinator.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import UIKit

class MainCoordinator {
    var navigationController: UINavigationController
    var mainRepository = MainRepository()
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
        mainRepository.mainCoordinator = self
    }
    
    func start() {
        let signViewModel = SignViewModel()
        signViewModel.mainRepository = mainRepository
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "SignViewController") as? SignViewController {
            viewController.signViewModel = signViewModel
            viewController.mainCoordinator = self
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func callFeedViewController() {
        let feedViewModel = FeedViewModel()
        feedViewModel.mainRepository = mainRepository
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        DispatchQueue.main.async {
            if let viewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController {
                viewController.feedViewModel = feedViewModel
                viewController.mainCoordinator = self
                self.navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func callPostViewController() {
        let currentViewController = navigationController.topViewController as? FeedViewController
        let postViewModel = PostViewModel()
        postViewModel.mainRepository = mainRepository
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController {
            
            viewController.postViewModel = postViewModel
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
    
    func showErrorMessage(statusCode: StatusCode) {
        if statusCode == .success { return }
        
        DispatchQueue.main.async {
            let currentViewController = self.navigationController.topViewController
            let alert = UIAlertController(title: "Alert", message: statusCode.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            currentViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
