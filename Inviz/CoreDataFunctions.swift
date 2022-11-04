//
//  CoreDataFunctions.swift
//  Inviz
//
//  Created by Ritesh Ranka on 2022-10-29.
// 

import Foundation
import CoreData
import Alamofire

// The data structure we will parse the data into
struct Notes: Decodable {
    var title: String
    var date: String
    var _id: String
    var note: String
    var email: String
    var company: String
    var username: String
}

class APIMethods{

    var delegate: DataDelegate?
    static let functions = APIMethods()
    
    func fetchNotes() {
        AF.request("https://invizin.herokuapp.com/fetch").response { response in
    
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            
                // Once the data is recieved pass it using the delegat protocol
                self.delegate?.updateArray(newArray: utf8Text)
                
            }
        }
    }
    
    func addNote(username: String, email: String, gender: String, company: String, title: String, note: String, date: String) {
        print(note)
        AF.request("https://invizin.herokuapp.com/form", method: .post,  encoding: URLEncoding.httpBody, headers: ["email":email, "username":username, "gender":gender, "company":company, "title": title, "note": note, "date": date ]).responseJSON { (response) in
        }
    }
    
    func deleteNote(id: String) {
        AF.request("https://invizin.herokuapp.com/delete", method: .post,  encoding: URLEncoding.httpBody, headers: ["id": id]).responseJSON { (response) in
        }
    }
    
    func updateNote(username: String, email: String, gender: String, company: String, id: String, title: String, note: String, date: String) {
        AF.request("https://invizin.herokuapp.com/update", method: .post,  encoding: URLEncoding.httpBody, headers: ["id": id, "email":email, "username":username, "gender":gender, "company":company, "title": title, "note": note, "date": date ]).responseJSON{ (response) in
        }
    }
    
}

