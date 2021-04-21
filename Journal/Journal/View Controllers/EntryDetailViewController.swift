//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Cameron Stuart on 12/30/20.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    //MARK: - Properties
    //Our landing pads
    var entry: Entry?
    var journal: Journal?

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up our delegates
        titleTextField.delegate = self
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func clearAllButtonTapped(_ sender: Any) {
        //Clears out all of our text
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //Making sure that we have text
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty,
              let journal = journal else { return }
        
        if let entry = entry {
            //If we have an entry we are going to update it
            EntryController.update(entry: entry, title: title, body: body)
        } else {
            //if we don't have an entry we are going to create one
            EntryController.createEntryWith(title: title, body: body, journal: journal)
        }
        //Removes the top view off of our Navigation Stack
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helper Methods
    ///Going to get called when we press return while typing in a textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ///Dismisses the keyboard
        textField.resignFirstResponder()
    }
    
    /**
     - Description: If we have an Entry then the user wants to update or view that Entry. In order to allow them to do that we are going to display the data from our passed entry. If we don't have an entry then the user is creating a new entry so we have no need to load any data
     */
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
} //End of class
