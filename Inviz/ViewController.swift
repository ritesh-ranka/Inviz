//
//  ViewController.swift
//  Inviz
//
//  Created by Ritesh Ranka on 2022-10-29.
//

import UIKit
import SwiftyJSON
import FirebaseAuth
import Firebase

// Custom protocol that parses the JSON and updated the arrray
protocol DataDelegate {
    func updateArray(newArray: String)
}

class ViewController: UIViewController {
    
    var userEmail = ""
    
    @IBOutlet weak var tableView: UITableView!
    // Array of notes objects from the database
    var notesArray = [Notes]()
    
    // Need to send some data to the next viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //guard let vc = segue.destination as? AddNoteViewController else {return}
        if let vc = segue.destination as? AddNoteViewController {
            // If we are updating a note, tell the addnotecontroller to update, and give position of item to update
            if segue.identifier == "updateNoteSegue" {
                // Give the reverse index (0 in the table view is the oldest item in database instead of newest)
                vc.update = true
                vc.isValidDelete = true
                vc.note = notesArray[ (notesArray.count-1) - ((tableView.indexPathForSelectedRow)?.row ?? 0)]
            }
        }
        if let vc = segue.destination as? ShowInfoViewController {
                vc.notes = notesArray[ (notesArray.count-1) - ((tableView.indexPathForSelectedRow)?.row ?? 0)]
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // the delegate is the class that handles the API requests
        self.navigationItem.setHidesBackButton(true, animated: false)
        APIMethods.functions.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let users = db.collection("users")
        let query = users.whereField("uid", isEqualTo: userID)
        query.getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                        //print("\(firstName) => \(lastName)")
                    self.userEmail = (Auth.auth().currentUser?.email ?? nil)!
                        //print("\(email)")
                }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Update and load the new data into the tableview
        APIMethods.functions.fetchNotes()
        self.tableView.reloadData()
    }
    
    // Everytime the list of notes is shown, update the array of notes and the tableview
    override func viewWillAppear(_ animated: Bool) {
        APIMethods.functions.fetchNotes()
        self.tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(indexPath.row)")
        let currentUser = notesArray[(notesArray.count-1) - ((tableView.indexPathForSelectedRow)?.row ?? 0)].email
//        print("\(currentUser), \(userEmail)")
        // instantiate the AddViewController class
        if currentUser != userEmail {
            performSegue(withIdentifier: "showInfoSegue", sender: nil)
            return
        }
        else {
            performSegue(withIdentifier: "updateNoteSegue", sender: nil)
            return
        }
    }
    // Don't need a didselectrow function because it uses a segue through stroyboards instead
    // Return a custom cell height of 85
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}

extension ViewController: UITableViewDataSource {
    
    // Render as many rows as items
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let arrayIndexReverse = (notesArray.count-1) - indexPath.row
            APIMethods.functions.deleteNote(id: notesArray[arrayIndexReverse]._id)
            APIMethods.functions.fetchNotes()
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
        }
    }
    
    // Customize each cell with date, note and title from the database item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Want to display the notes from newest to oldest so show the array in reverse
        let arrayIndexReverse = (notesArray.count-1) - indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototype", for: indexPath) as! NoteTableViewCell
        cell.timeLabel.text = notesArray[arrayIndexReverse].date
        cell.titleLabel.text = notesArray[arrayIndexReverse].company+" - "+notesArray[arrayIndexReverse].title
        let str = notesArray[arrayIndexReverse].note
        if str.count > 0 {
            if str.count >= 40 {
                let index = str.index(str.startIndex, offsetBy: 40)
                cell.noteLabel.text = str[..<index] + "..."
            }else{
                cell.noteLabel.text = str
            }
            
        }else{
            cell.noteLabel.text = "Editable Interview Exp."
        }
        return cell
    }
}

extension ViewController: DataDelegate {
    
    // Get data from the API call and parse it
    func updateArray(newArray: String) {
        do{
            notesArray = try JSONDecoder().decode([Notes].self,from: newArray.data(using: .utf8)!)
        }catch let jsonErr {
            print(jsonErr)
        }
        self.tableView.reloadData()
    }
    
}
