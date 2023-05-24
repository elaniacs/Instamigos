//
//  FeedCellModel.swift
//  Instamigos
//
//  Created by Cáren Sousa on 20/05/23.
//

import Foundation

struct FeedCellModel {
    let createdAt: String
    let avatar: String
    let content: String
    
    func calculatesElapsedTime(postDate: Date?) -> String {
         
        if let postDate = postDate {
            let currentDate = Date()
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: postDate, to: currentDate)
            
            let timeFormatter = DateComponentsFormatter()
            timeFormatter.unitsStyle = .full
            timeFormatter.calendar?.locale = Locale(identifier: "en_US")
            timeFormatter.maximumUnitCount = 1
            timeFormatter.unitsStyle = .abbreviated
            
            let timePassed = timeFormatter.string(from: components)
            
            return timePassed ?? ""
        }
        return ""
    }
}


