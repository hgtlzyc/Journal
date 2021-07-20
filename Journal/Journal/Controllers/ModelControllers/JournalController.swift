//
//  JournalController.swift
//  Journal
//
//  Created by lijia xu on 7/20/21.
//

import Foundation

class JournalController {
    
    static let shared = JournalController()
    
    var journals: [Journal] = []
    
    // MARK: - CRUD Functions
    // Journal Related
    func createJournalWith(title: String) {
        let newJournal = Journal(name: title)
        journals.append(newJournal)
        saveToPersistentStorage()
    }
    
    func delete(journal: Journal) {
        guard let indexToDelete = journals.firstIndex(of: journal) else { return }
        journals.remove(at: indexToDelete)
        saveToPersistentStorage()
    }
    
    // Entries related
    
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        saveToPersistentStorage()
        
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let indexToRemove = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: indexToRemove)
        saveToPersistentStorage()
    }
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Data Persistance
    func saveToPersistentStorage() {
        let je = JSONEncoder()
        
        do {
            let data = try je.encode(journals)
            try data.write(to: fileURL())
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        let jd = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            journals = try jd.decode([Journal].self, from: data)
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    // MARK: - Helper
    private func fileURL() -> URL {
     let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let documentsDirectoryURL = urls[0].appendingPathComponent("Journals.json")
     return documentsDirectoryURL
    }
    
}
