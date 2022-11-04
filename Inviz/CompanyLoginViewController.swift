//
//  CompanyLoginViewController.swift
//  Inviz
//
//  Created by Sneha Tandri on 05/11/22.
//

import UIKit

class CompanyLoginViewController: UIViewController {
    @IBOutlet var companyName: UITextField!
    @IBOutlet var companyKey: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let companyName = companyName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let companyKey = companyKey.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
