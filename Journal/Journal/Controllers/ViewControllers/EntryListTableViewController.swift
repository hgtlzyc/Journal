//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by lijia xu on 7/19/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    var journal: Journal?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        guard let journal = journal else { return cell }
        
        let dateString = journal.entries[indexPath.row].timeStamp.getStringForm()
        
        cell.textLabel?.text = journal.entries[indexPath.row].title
        
        cell.detailTextLabel?.text = dateString
        return cell
    }
    
    
    // MARK: - Edit Table View
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let journal = journal else { return }
        
        if editingStyle == .delete {
            let entryToDelete = journal.entries[indexPath.row]
            
            EntryController.delete(entry: entryToDelete, in: journal)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let targetVC = segue.destination as? EntryDetailViewController,
              let journal = journal else { return }
        targetVC.journal = journal
        
        if segue.identifier == "toEntryDetailsVC" {
            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
            targetVC.entry = journal.entries[selectedIndex.row]
        }
    }

}
