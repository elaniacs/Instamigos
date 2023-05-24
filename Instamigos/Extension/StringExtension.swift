//
//  StringExtension.swift
//  Instamigos
//
//  Created by Cáren Sousa on 24/05/23.
//

import Foundation

extension String {
    
    func toDate(dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.date(from: self)
    }
}

