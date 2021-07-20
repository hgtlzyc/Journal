//
//  JournalListViewController.swift
//  Journal
//
//  Created by lijia xu on 7/20/21.
//

import UIKit

class JournalListViewController: UIViewController {

    
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    @IBOutlet weak var createNewJournalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        setupView()
        
        JournalController.shared.loadFromPersistentStorage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
    }
    
    // MARK: - Setup View and VC
    func setupVC() {
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
        
        journalTitleTextField.delegate = self
    }
    
    func setupView() {
        createNewJournalButton.isEnabled = false
    }
    
    
    // MARK: - Actions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        guard let title = journalTitleTextField.text, !title.isEmpty else { return }
        JournalController.shared.createJournalWith(title: title)
        journalTitleTextField.text = nil
        journalTitleTextField.resignFirstResponder()
        journalListTableView.reloadData()
    }
    
    @IBAction func textFieldChaned(_ sender: Any) {
        guard let textField = sender as? UITextField,
              let count = textField.text?.count else { return }
        createNewJournalButton.isEnabled = count > 0 ? true : false
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEntryList" {
            guard let destinationVC = segue.destination as? EntryListTableViewController,
                  let indexPathToPass = journalListTableView.indexPathForSelectedRow else { return }
            destinationVC.journal = JournalController.shared.journals[indexPathToPass.row]
        }
        
    }

}//End Of VC

// MARK: - Textfield Extension

extension JournalListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        journalTitleTextField.resignFirstResponder()
        return true
    }
}


// MARK: - Extension TableView Data Source
extension JournalListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        cell.textLabel?.text = JournalController.shared.journals[indexPath.row].name
        
        let entriesCount = JournalController.shared.journals[indexPath.row].entries.count
        
        cell.detailTextLabel?.text = entriesCount > 0 ? "\(entriesCount)" : ""
        
        return cell
    }
    
    
    // MARK: - Edit Table View
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let journalToDelete = JournalController.shared.journals[indexPath.row]
            
            JournalController.shared.delete(journal: journalToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}



