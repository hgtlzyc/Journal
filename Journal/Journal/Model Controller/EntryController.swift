//
//  EntryController.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import Foundation

class EntryController {
    
    // MARK: - Properties
    //Shared instance
    static let shared = EntryController()
    
    //Source of truth
    var entries: [Entry] = []
    
    // MARK: - CRUD Methods
    
    /**
    This function creates an `Entry`
    - Parameters:
    - title: Sets the `Title` of our new `Entry`
    - details: Sets the `Details` of our new `Entry`
    */
    func createEntryWith(title: String, body: String) {
        let newEntry = Entry(title: title, body: body)
        entries.append(newEntry)
        saveToPersistentStorage()
    }
    
    /// Used to Delete our `Entry`
    /// - Parameter entry: The `Entry` that we want to delete
    ///finds the index of the entry we want to delete in the entries array...then removes at that index
    func deleteEntry(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
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
            let data = try JSONEncoder().encode(entries)
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
            let entries = try JSONDecoder().decode([Entry].self, from: data)
            self.entries = entries
        } catch {
            print("======== ERROR ========")
            print("Function: \(#function)")
            print("Error: \(error)")
            print("Description: \(error.localizedDescription)")
            print("======== ERROR ========")
        }
    }
}
