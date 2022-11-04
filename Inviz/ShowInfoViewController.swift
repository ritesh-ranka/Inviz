//
//  ShowInfoViewController.swift
//  Inviz
//
//  Created by Ritesh Ranka on 29/10/22.
//

import UIKit
import SwiftyJSON
import FirebaseAuth
import Firebase

class ShowInfoViewController: UIViewController {
    
    
    var isValidDelete = false
    var update = false
    var notes:  Notes!
    var firstName = ""
    var lastName = ""
    var email = ""

    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var pageTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    override func viewWillAppear(_ animated: Bool) {
        APIMethods.functions.fetchNotes()
        note.text = notes.note
        pageTitle.text = notes.title
        company.text = notes.company
        self.title = notes.title
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
