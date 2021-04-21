//
//  JournalListViewController.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up our tableView delegate and dataSource
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
        
        //loading any saved Journals we have in our local files
        JournalController.shared.loadFromPersistentStorage()
    }
    
    ///Will update our table view everytime the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        //Making sure we have text in our textField
        guard let title = journalTitleTextField.text, !title.isEmpty else { return }
        //Creating a new Journal using the text as our title
        JournalController.shared.createJournalWith(title: title)
        //reloading the tableView to show the updated information on our SOT
        journalListTableView.reloadData()
        //resetting the textField's text to empty
        journalTitleTextField.text = ""
    }
    
    //MARK: - TableView Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Will set our number of rows equal to the number of journals we have
        return JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        //Grabbing our journal based on the index of the cell
        let journal = JournalController.shared.journals[indexPath.row]
        
        //setting our cells title equal to the journal's title
        cell.textLabel?.text = journal.title
        //setting our detail label to the number of entries in the journal's entries array
        cell.detailTextLabel?.text = "\(journal.entries.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // called to delete our cell on swipe
        /// Grabs the `Journal` that we want to delete
        let journalToDelete = JournalController.shared.journals[indexPath.row]
        /// Calls the delete function on our `JournalController`
        JournalController.shared.delete(journal: journalToDelete)
        // Delete the row from the tableView
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        //Identifier
            // We are checking to see if the identifier of our segue matches "toEntryList". If it does then we will run the code inside, if not then we will just pass over it.
        if segue.identifier == "toEntryList" {
            //IndexPath
            /// Making sure that we have a selected row that we can use to grab a `Journal`
            guard let indexPath = journalListTableView.indexPathForSelectedRow,
                  //Destination
                      //Making sure that our segues destination is an `EntryListTableViewController`, this also allows us to get access to the properties on `EntryListTableViewController`
                  let destination = segue.destination as? EntryListTableViewController else { return }
            //Object to Send
                //Grabs the journal that we want to send based off of the index that we unwrapped earlier
            let journalToSend = JournalController.shared.journals[indexPath.row]
            //Object to Receive
                /// sends our journal to the journal landing pad on our `EntryListTableViewController`
            destination.journal = journalToSend
        }
    }
} //End of class

