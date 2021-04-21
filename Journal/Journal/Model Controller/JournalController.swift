//
//  JournalController.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import Foundation

class JournalController {
    //MARK: - Properties
    //Shared Instance
    static let shared = JournalController()
    
    //Source of Truth (SOT)
    var journals: [Journal] = []
    
    //MARK: - CRUD Methods
    
    /**
    This function creates a `Journal`
    - Parameters:
    - title: Sets the `title` of our new `Journal`
     Then appends newJournal to our SOT
    */
    func createJournalWith(title: String) {
        let newJournal = Journal(title: title)
        journals.append(newJournal)
        saveToPersistentStorage()
    }
    
    /// Used to Delete a `Journal`
    /// - Parameter journal: The `Journal` that we want to delete
    func delete(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    /**
        Adds an Entry to a Journal
     - Parameters:
     - journal: the Journal that we want to add the Entry to
     - entry: the Entry that we would like to add to the Journal's entries array
     */
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        saveToPersistentStorage()
    }
    
    /**
        Removes an Entry to from a Journal
     - Parameters:
     - journal: the Journal that we want to remove the Entry from
     - entry: the Entry that we would like to remove from the Journals entries array
     */

    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    //MARK: - JSON Persistence
    /**
    Used to create a file path for a location to save our data
    - Returns: A URL used to specify file location
    */
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    /**
    Saves the current entries array as data to a file on disk
    */
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch {
            print("======== ERROR ========")
            print("Function: \(#function)")
            print("Error: \(error)")
            print("Description: \(error.localizedDescription)")
            print("======== ERROR ========")
        }
    }
    
    /**
    Loads saved data from disk, decodes the data into an array of Entry and assigns that array to the source of truth (entries) on the Entry Controller
    */
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            let journals = try JSONDecoder().decode([Journal].self, from: data)
            self.journals = journals
        } catch {
            print("======== ERROR ========")
            print("Function: \(#function)")
            print("Error: \(error)")
            print("Description: \(error.localizedDescription)")
            print("======== ERROR ========")
        }
    }
} //End of class
