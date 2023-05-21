//
//  PostViewModel.swift
//  Instamigos
//
//  Created by Cáren Sousa on 20/05/23.
//

import Foundation

class PostViewModel {
    let mainRepository = MainRepository()
    
    func createPost(content: String, completion: (() -> Void)?) {
        mainRepository.postCreatePost(content: content) {
            completion?()
        }
    }
}


