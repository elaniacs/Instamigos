//
//  FeedViewController.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    weak var mainCoordinator: MainCoordinator?
    var feedViewModel: FeedViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        title = "Feed"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItems = [addButton]
        
        let customButton = UIButton(type: .system)
        customButton.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
        
        let customBarButton = UIBarButtonItem(customView: customButton)
        navigationItem.leftBarButtonItem = customBarButton
        
        reloadData()
    }
    
    
    @objc func customButtonTapped() {
        let alertController = UIAlertController(title: "Profile", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Logout", style: .default, handler: { _ in
            self.feedViewModel?.postUserLogout {
                KeychainManager.shared.deleteToken()
                UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                self.mainCoordinator?.backToSign()
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Delete account", style: .default, handler: { _ in
            self.mainCoordinator?.showAlert(viewController: self, message:  "Feature under development. Will be available soon!", handler: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    
    @objc
    func addButtonTapped() {
        mainCoordinator?.callPostViewController()
    }
    
    func reloadData() {
        feedViewModel?.getAllPosts() {
            DispatchQueue.main.async {
                self.feedTableView.reloadData()
            }
        }
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel?.feedCell.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        
        if let data = feedViewModel?.feedCell[indexPath.row] {
            cell.populateCell(data: data)
        }
        
        if let userId = feedViewModel?.postsArray[indexPath.row].user_id {
            feedViewModel?.getUserBy(userId: userId) { name in
                cell.getName(name: name)
            }
        }
        
        return cell
        
    }
}
