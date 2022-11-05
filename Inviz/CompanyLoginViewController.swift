//
//  CompanyLoginViewController.swift
//  Inviz
//
//  Created by Ritesh Ranka on 05/11/22.
//

import UIKit

class CompanyLoginViewController: UIViewController {
    @IBOutlet var login: UIButton!
    @IBOutlet var companyName: UITextField!
    @IBOutlet var companyKey: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        self.login.isEnabled = false
        let companyName = companyName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let companyKey = companyKey.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //do auth and if there is an error, show alert and do
        //self.login.isEnabled = true
    }
    
}
