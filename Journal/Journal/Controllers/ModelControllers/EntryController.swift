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
    
    // MARK: - CRUD Methods
    func createEntryWith(title: String, body: String) {
        let newEntry = Entry(title: title, text: body)
        entries.append(newEntry)
        saveToPersistentStorage()
    }
    
    func delete(entry: Entry) {
        guard let indexToDelete = entries.firstIndex(of: entry) else { return }
        
        entries.remove(at: indexToDelete)
        saveToPersistentStorage()
    }
    
    // MARK: - Data Persistance
    func saveToPersistentStorage() {
        let je = JSONEncoder()
        
        do {
            let data = try je.encode(entries)
            try data.write(to: fileURL())
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        let jd = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            entries = try jd.decode([Entry].self, from: data)
        } catch let e {
            print(e)
        }
    }
    
    // MARK: - Make init private
    private init() {}
    
    // MARK: - Helper
    private func fileURL() -> URL {
     let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
     return documentsDirectoryURL
    }
    
}
