//
//  Journal.swift
//  Journal
//
//  Created by lijia xu on 7/20/21.
//

import Foundation

class Journal: Codable {
    
    let name: String
    var entries: [Entry]
    let uuid: String
    
    internal init(name: String, entries: [Entry] = [], uuid: String = UUID().uuidString) {
        self.name = name
        self.entries = entries
        self.uuid = uuid
    }

}


extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
       return lhs.uuid == rhs.uuid
    }
}
