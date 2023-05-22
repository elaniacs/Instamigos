//
//  PostResponse.swift
//  Instamigos
//
//  Created by Cáren Sousa on 21/05/23.
//

import Foundation

struct PostResponse: Decodable {
    let id: String
    let content: String
    let user_id: String
    let created_at: String
    let updated_at: String
}

struct PostLikeResponse: Decodable {
    let like_count: Int
    let id: String
    let content: String
    let updated_at: String
    let user_id: String
    let created_at: String
}
