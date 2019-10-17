//
//  AuthenticationViewController.swift
//  CarsList
//
//  Created by MacBook Air on 11/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import UIKit
import Firebase

class AuthenticationViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: "SignInSegue", sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emailTextField.text = ""
        passwordTextField.text = ""
    }

    func callAlert(withText text: String) {
        let alert = UIAlertController(title: "\(text)", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true)
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            callAlert(withText: "Enter the login/password")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] dataResult, error in
            if error != nil {
                self?.callAlert(withText: "Error occured")
                print(error!.localizedDescription)
                return
            }
            if dataResult != nil {
                self?.performSegue(withIdentifier: "SignInSegue", sender: nil)
                return
            }
            self?.callAlert(withText: "No such login/password")
        }
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            callAlert(withText: "Enter the login and password")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] dataResult, error in
            if error != nil {
                self?.callAlert(withText: "Error occured")
                print(error!.localizedDescription)
                return
            }
            if dataResult == nil {
                self?.callAlert(withText: "No such login/password")
            }
        }
    }
    
//    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
//        guard unwindSegue.identifier == "SignOutSegue" else { return }
//        do {
//                   try Auth.auth().signOut()
//               }
//               catch {
//                   print(error.localizedDescription)
//               }
//               dismiss(animated: true, completion: nil)
//    }
    
}
