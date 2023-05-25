//
//  PostViewModel.swift
//  Instamigos
//
//  Created by Cáren Sousa on 20/05/23.
//

import Foundation

class PostViewModel {
    var mainRepository: MainRepository?
    
    func createPost(content: String, completion: (() -> Void)?) {
        mainRepository?.postCreatePost(content: content) { responseData in
            if responseData != nil {
                completion?()
            }
        }
    }
    
    func savePostChanges(postContent: String) {
        let defaults = UserDefaults.standard
        defaults.set(postContent, forKey: "PostContet")
        defaults.synchronize()
    }
}

