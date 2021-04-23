//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    ///When the view first gets loaded, it loads any saved entries from our data store
    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.loadFromPersistentStorage()
    }
    
    ///Will update our table view everytime the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Will set our number of rows equal to the number of entries we have
        return EntryController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        //Grabbing our entry based on the index of the cell
        let entry = EntryController.shared.entries[indexPath.row]
        
        //setting our cells title equal to the entry's title
        cell.textLabel?.text = entry.title
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // called to delete our cell on swipe
            /// Grabs the `Entry` that we want to delete
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            /// Calls the delete function on our `EntryController`
            EntryController.shared.deleteEntry(entry: entryToDelete)
            // Delete the row from the tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        //Identifier
            // We are checking to see if the identifier of our segue matches "showEntry". If it does then we will run the code inside, if not then we will just pass over it.
        if segue.identifier == "showEntry" {
            /// Making sure that we have a selected row that we can use to grab an `Entry`
            guard let indexPath = tableView.indexPathForSelectedRow,
                  //Destination
                      ///Making sure that our segues destination is an `EntryDetailViewController`, this also allows us to get access to the properties on `EntryDetailViewController`
                  let destination = segue.destination as? EntryDetailViewController else { return }
            //Object to Send
                //Grabs the entry that we want to send based off of the index that we unwrapped earlier
            let entryToSend = EntryController.shared.entries[indexPath.row]
            //Object to Receive
                /// sends our entry to the entry on our `EntryDetailViewController`
            destination.entry = entryToSend
        }
    }
}
