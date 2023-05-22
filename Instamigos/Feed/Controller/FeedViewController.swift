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
    let viewModel = FeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItems = [addButton]
        
        reloadData()
    }
    
    @objc
    func addButtonTapped() {
        mainCoordinator?.callPostViewController()
    }
    
    func reloadData() {
        viewModel.getAllPosts() {
            DispatchQueue.main.async {
                self.feedTableView.reloadData()
            }
        }
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.feedCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        
        cell.populateCell(data: viewModel.feedCell[indexPath.row])
        
        viewModel.getUserBy(userId: viewModel.postsArray[indexPath.row].user_id) { name in
            cell.getName(name: name)
        }

        return cell
        
    }
}
