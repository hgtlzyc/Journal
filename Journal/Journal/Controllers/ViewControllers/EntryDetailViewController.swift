//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by lijia xu on 7/19/21.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextField!
    
    // MARK: - Vars
    var entry: Entry?
    var journal: Journal?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Update View
    func updateViews() {
        guard let entry = entry else { return }
        
        titleTextField.text = entry.title
        bodyTextView.text = entry.text
    }
    
    
    // MARK: - IBActions
    @IBAction func clearButtonPressed(_ sender: Any) {
        titleTextField.text = nil
        bodyTextView.text = nil
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        defer {
            navigationController?.popViewController(animated: true)
        }
        
        guard let title =  titleTextField.text,
              let body = bodyTextView.text else { return }
        
        switch (entry, journal) {
        case let ( nil, journal? ):
            EntryController.createEntryWith(title: title, body: body, in: journal)
            
        case let ( entry?, _? ):
            EntryController.update(title: title, body: body, entry: entry)
            
        default:
            print("Unexpected Case in save button tapped")
        }
        
    }
    
}
