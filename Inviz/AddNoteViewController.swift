//
//  AddNoteViewController.swift
//  Inviz
//
//  Created by Ritesh Ranka on 2022-10-29.
// 

import UIKit
import SwiftyJSON
import FirebaseAuth
import Firebase

class AddNoteViewController: UIViewController {
    
    // update tells save button to update, save tells button to add, and indexOfUpdate tells what to update in the database
    var isValidDelete = false
    var update = false
    var note: Notes!
    var firstName = ""
    var lastName = ""
    var email = ""
    
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var noteField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Add borders to the title and note textfields (cant do in stroyboard)
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.layer.borderWidth = 1.2
        noteField.layer.borderWidth = 1.2
        companyField.layer.borderWidth = 1.2
        titleField.layer.cornerRadius = 3.0
        noteField.layer.cornerRadius = 3.0
        companyField.layer.cornerRadius = 3.0
        titleField.layer.borderColor = UIColor.lightGray.cgColor
        noteField.layer.borderColor = UIColor.lightGray.cgColor
        companyField.layer.borderColor = UIColor.lightGray.cgColor
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let users = db.collection("users")
        let query = users.whereField("uid", isEqualTo: userID)
        query.getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.lastName = (document.data()["lastname"] as? String ?? nil)!
                        self.firstName = (document.data()["firstname"] as? String ?? nil)!
                        //print("\(firstName) => \(lastName)")
                        self.email = (Auth.auth().currentUser?.email ?? nil)!
                        //print("\(email)")
                    }
                }
        }
    }
    
    
    // If we are updating a note, we want the fields to already have the current values in them
    override func viewWillAppear(_ animated: Bool) {
        if update == true {
            // set the fields to the value of the note we are updating and change top title to edit instead of new note
            noteField.text = note.note
            titleField.text = note.title
            companyField.text = note.company
            self.title = "Edit"
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        if isValidDelete == true {
            // Pass the note id and return back to the main view
            APIMethods.functions.deleteNote(id: note._id)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // The save button. By deafult it adds.
    @IBAction func saveClick(_ sender: Any) {
        // Get the current date and turn it into a string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.string(from: Date())
        
        // If there is a valid note, either add or update
        if noteField.text! != "" && titleField.text! != "" {
            if update == true {
                
                APIMethods.functions.updateNote(username: firstName+" "+lastName, email: email, company:companyField.text! , id: note._id, title: titleField.text!, note: noteField.text!, date: date)
                
            } else  {
                
                APIMethods.functions.addNote(username: firstName+" "+lastName, email: email, company: companyField.text!, title: titleField.text!, note: noteField.text!, date: date)
                
            }

            // Return back to main screen after click
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
