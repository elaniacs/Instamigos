//
//  FeedViewModel.swift
//  Instamigos
//
//  Created by Cáren Sousa on 21/05/23.
//

import Foundation

class FeedViewModel {
    
    let mainRepository = MainRepository()
    var feedCell: [FeedCellModel] = []
    var postsArray: [PostLikeResponse] = []
    
    func getAllPosts(completion: (() -> Void)?) {
        mainRepository.getAllPosts() { responseData in
            self.postsArray = responseData
            self.feedCell = self.convertToFeedCellModels(posts: responseData)
            completion?()
        }
    }
    
    func getUserBy(userId: String, completion: ((String) -> Void)?) {
        mainRepository.getUserBy(userId: userId) { responseData in
            completion?(responseData.name)
        }
    }
    
    func convertToFeedCellModels(posts: [PostLikeResponse]) -> [FeedCellModel] {
        var feedCellModels: [FeedCellModel] = []
        
        for post in posts {
            let feedCell = FeedCellModel(createdAt: post.created_at, avatar: "", content: post.content)
            feedCellModels.append(feedCell)
        }
        
        return feedCellModels
    }
    
    func postUserLogout(completion: (() -> Void)?) {
        mainRepository.postUserLogout {
            completion?()
        }
    }
    
    func postUser(name: String, email: String, password: String) {
        let data = CreateUserRequest(name: name, email: email, password: password)
        mainRepository.postUser(data: data)
    }
    
    func loginUser(email: String, password: String, completion: (() -> Void)?) {
        let authentication = BasicAuthenticationModel(email: email, password: password)
        mainRepository.loginUser(authentication: authentication) { responseData in
            if let token = responseData.token {
                KeychainManager.shared.saveToken(token: token)
                completion?()
            }
        }
    }
}
    
