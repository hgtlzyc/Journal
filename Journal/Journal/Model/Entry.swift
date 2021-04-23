//
//  Entry.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import Foundation

class Entry: Codable {
    
    //MARK: - Properties
    var title: String
    var body: String
    let timestamp: Date
    
    //MARK: - Initializer
     // By passing in timestamp it gives us the option to set our own if we want in the future. If we don't pass one in then it just has a default value of the current Date
    init(title: String, body: String, timestamp: Date = Date()) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

//MARK: - Extension
// conforms our Entry to Equatable so we can compare two instances of Entry to determine whether they are the same Entry.  Checks all properties of the entries and returns true only if all properties are the same.
extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
    }
}
