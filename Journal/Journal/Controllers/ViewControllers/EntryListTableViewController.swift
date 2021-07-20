//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by lijia xu on 7/19/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.loadFromPersistentStorage()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entryForCell = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entryForCell.title
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryDetailsVC" {
            guard let targetVC = segue.destination as? EntryDetailViewController,
                  let selectedIndex = tableView.indexPathForSelectedRow else { return }
            
            targetVC.entry = EntryController.shared.entries[selectedIndex.row]
        }
    }

}
