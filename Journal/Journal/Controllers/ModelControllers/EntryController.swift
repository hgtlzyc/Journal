//
//  EntryController.swift
//  Journal
//
//  Created by lijia xu on 7/19/21.
//

import Foundation

class EntryController {
    
    // MARK: - CRUD Methods
    static func createEntryWith(title: String, body: String, in journal: Journal) {
        let newEntry = Entry(title: title, text: body)
        JournalController.shared.addEntryTo(journal: journal, entry: newEntry)
    }
    
    static func update(title: String, body: String, entry: Entry){
        entry.title = title
        entry.text = body
        JournalController.shared.saveToPersistentStorage()
    }
    
    static func delete(entry: Entry, in journal: Journal) {
        JournalController.shared.removeEntryFrom(journal: journal, entry: entry)
    }

}
