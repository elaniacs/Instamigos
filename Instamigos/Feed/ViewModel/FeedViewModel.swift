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
}
