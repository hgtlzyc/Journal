//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    //MARK: - Properties
    //Our landing pad
    var journal: Journal?
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    ///Will update our table view everytime the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Will set our number of rows equal to the number of entries we have in our journal, otherwise will set 0
        return journal?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        //Grabbing our entry based on the index of the cell
        guard let entry = journal?.entries[indexPath.row] else { return UITableViewCell() }
        
        //setting our cells title equal to the entries title
        cell.textLabel?.text = entry.title

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // called to delete our cell on swipe
            /// Grabs the `Entry` that we want to delete
            guard let journal = journal else { return }
            let entryToDelete = journal.entries[indexPath.row]
            
            ///Calls the delete function on our `EntryController`
            EntryController.deleteEntry(entry: entryToDelete, journal: journal)
            
            // Delete the row from the tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Making sure we have a journal to send over
        //Making sure that our segues destination is an `EntryDetailViewController`, this also allows us to get access to the properties on `EntryDetailViewController`
        guard let journal = journal,
              let destination = segue.destination as? EntryDetailViewController else { return }
        
        // We are checking to see if the identifier of our segue matches "showEntry". If it does then we will run the code inside, if not then we will just pass over it.
        if segue.identifier == "showEntry" {
            /// Making sure that we have a selected row that we can use to grab an `Entry`
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            //Grabs the entry that we want to send based off of the index that we unwrapped earlier
            let entryToSend = journal.entries[indexPath.row]
            // sends our entry and journal to the landing pads on our `EntryDetailViewController`
            destination.journal = journal
            destination.entry = entryToSend
            
        //Checking if the identifier of our segue matches "createNewEntry".  If it does then we will run the code inside, if not then we will just pass over it.
        } else if segue.identifier == "createNewEntry" {
            //Sends over our journal to the landing pad on our `EntryDetailViewController`
            destination.journal = journal
        }
    }
} //End of class
