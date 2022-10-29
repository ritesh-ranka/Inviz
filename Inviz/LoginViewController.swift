//
//  LoginViewController.swift
//  Inviz
//
//  Created by Ritesh Ranka on 25/10/22.
//

import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var login: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var forgotPassword: UIButton!
    @IBOutlet var registerUser: UIButton!
    func showErrorMsg(errorMsg: String){
        let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func loginButton(_ sender: Any) {
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.showErrorMsg(errorMsg: error!.localizedDescription)
                return
            }
            else {
                self.performSegue(withIdentifier: "loginSuccess", sender: self.login)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
                goToHome()
            }
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    func goToHome() {
        // if logged in go to home screen
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else {return}
        if sender == registerUser {
            segue.destination.navigationItem.title = "Register"
        } else if sender == forgotPassword {
            segue.destination.navigationItem.title = "Reset Password"
        }
        
    }
}

