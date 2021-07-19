//
//  Entry.swift
//  Journal
//
//  Created by lijia xu on 7/19/21.
//

import Foundation

class Entry: Codable {
    
    let title: String
    let text: String
    let timeStamp: Date
    
    init(title: String, text: String, timeStamp: Date = Date()) {
        self.title = title
        self.text = text
        self.timeStamp = timeStamp
    }
    
}

extension Entry: Equatable {
    
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title &&
               lhs.text == rhs.text &&
               lhs.timeStamp == rhs.timeStamp
    }
    
}

