//
//  EntryController.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import Foundation

class EntryController {
    
    //MARK: - CRUD Methods
    
    /**
    This function creates an `Entry`
    - Parameters:
    - title: Sets the `Title` of our new `Entry`
    - body: Sets the `body` of our new `Entry`
     -journal:  establishes which `Journal` to add newEntry to
     Calls addEntryTo() function from our `JournalController` to add newEntry to the passed in `Journal`
    */
    static func createEntryWith(title: String, body: String, journal: Journal) {
        let newEntry = Entry(title: title, body: body)
        JournalController.shared.addEntryTo(journal: journal, entry: newEntry)
    }
    
    /**
    This function deletes an `Entry`
    - Parameters:
    - entry: which entry should be deleted
    - journal: the `Journal` from whose entries array the entry will be removed
     Calls the removeEntryFrom() function from our `JournalController` to remove the entry
    */
    static func deleteEntry(entry: Entry, journal: Journal) {
        JournalController.shared.removeEntryFrom(journal: journal, entry: entry)
    }
    
    /**
    This function updates an `Entry`
    - Parameters:
    - entry: which `Entry` will be updated
    - title:  the new `title` of our `Entry`
    - body: the new `body` of our  `Entry`
    */
    static func update(entry: Entry, title: String, body: String) {
        entry.title = title
        entry.body = body
        JournalController.shared.saveToPersistentStorage()
    }
} //End of class
