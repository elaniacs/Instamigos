//
//  FeedViewModel.swift
//  Instamigos
//
//  Created by Cáren Sousa on 21/05/23.
//

import Foundation

class FeedViewModel {
    
    var mainRepository: MainRepository?
    var feedCell: [FeedCellModel] = []
    var postsArray: [PostLikeResponse] = []
    
    let cache = NSCache<NSString, AnyObject>()
    
    func getAllPosts(completion: (() -> Void)?) {
        mainRepository?.getAllPosts() { responseData in
            if let responseData = responseData {
                self.postsArray = responseData
                self.feedCell = self.convertToFeedCellModels(posts: responseData)
                completion?()
            }
        }
    }
    
    func getUserBy(userId: String, completion: ((String) -> Void)?) {
        if let cachedData = cache.object(forKey: userId as NSString) as? UserModel {
            completion?(cachedData.name)
            return
        }
        
        mainRepository?.getUserBy(userId: userId) { responseData in
            if let responseData = responseData {
                self.cache.setObject(responseData as AnyObject, forKey: userId as NSString)
                completion?(responseData.name)
            }
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
        mainRepository?.postUserLogout { responseData in
            if responseData != nil {
                completion?()
            }
        }
    }
}
    
