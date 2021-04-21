//
//  Journal.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import Foundation

class Journal: Codable {
    //MARK: - Properties
    let title: String
    var entries: [Entry]
    
    //MARK: - Initializer
    // By passing in a default value of an empty array into our initializer for our entries property, upon creation all Journals will have the entries property set to an empty array.  However we still have the option to pass in a different value for entries if we wanted to.
    init(title: String, entries: [Entry] = []) {
        self.title = title
        self.entries = entries
    }
} //End of class

//MARK: - Extension
// conforms our Journal to Equatable so we can compare two instances of Journal to determine whether they are the same Journal.  Checks all properties of the journals and returns true only if all properties are the same.
extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.title == rhs.title && lhs.entries == rhs.entries
    }
} //End of extension
