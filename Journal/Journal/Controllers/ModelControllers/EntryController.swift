//
//  EntryController.swift
//  Journal
//
//  Created by lijia xu on 7/19/21.
//

import Foundation

class EntryController {
    // MARK: - Shared Instance
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    // MARK: - Methods
    func createEntryWith(title: String, body: String) {
        let newEntry = Entry(title: title, text: body)
        entries.append(newEntry)
    }
    
    func delete(entry: Entry) {
        guard let indexToDelete = entries.firstIndex(of: entry) else { return }
        
        entries.remove(at: indexToDelete)
        
    }
    
    // MARK: - Make init private
    private init() {}
    
}
