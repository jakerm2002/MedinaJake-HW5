//
//  LoginViewController.swift
//  MedinaJake-HW5
//
//  Created by Jake Medina on 10/19/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIDTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        segmentedControl.selectedSegmentIndex = 0
        statusLabel.text = ""
        buttonLabel.setTitle("Sign In", for: .normal)
        confirmPasswordLabel.isHidden = true
        confirmPasswordTextField.isHidden = true
        
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        Auth.auth().addStateDidChangeListener() {
            (auth,user) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.userIDTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
    }
    
    // if a user clicks Sign Out in the main VC, then
    // we show the Sign In page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentedControl.selectedSegmentIndex = 0
        buttonLabel.setTitle("Sign In", for: .normal)
        confirmPasswordLabel.isHidden = true
        confirmPasswordTextField.isHidden = true
    }
    
    func clearFields() {
        userIDTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        statusLabel.text = ""
    }
    
    
    // Keyboard removal
    // Called when 'return' key pressed
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        // log in
        if segmentedControl.selectedSegmentIndex == 0 {
            if (userIDTextField.text!.isEmpty || passwordTextField.text!.isEmpty) {
                self.statusLabel.text = "One or more of the fields is missing."
            } else {
                Auth.auth().signIn(withEmail: userIDTextField.text!, password: passwordTextField.text!) {
                    (authResult,error) in
                    if let error = error as NSError? {
                        self.statusLabel.text = "\(error.localizedDescription)"
                    } else {
                        self.clearFields()
                    }
                }
            }
        } else { // sign up
            // check password fields match
            if (userIDTextField.text!.isEmpty || passwordTextField.text!.isEmpty || confirmPasswordTextField.text!.isEmpty) {
                self.statusLabel.text = "One or more of the fields is missing."
            } else if (passwordTextField.text != confirmPasswordTextField.text) {
                // don't match
                self.statusLabel.text = "Passwords do not match."
            } else {
                Auth.auth().createUser(withEmail: userIDTextField.text!, password: passwordTextField.text!) {
                    (authResult,error) in
                    if let error = error as NSError? {
                        self.statusLabel.text = "\(error.localizedDescription)"
                    } else {
                        self.clearFields()
                    }
                }
            }
        }
    }
    
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            buttonLabel.setTitle("Sign In", for: .normal)
            confirmPasswordLabel.isHidden = true
            confirmPasswordTextField.isHidden = true
            statusLabel.text = ""
        case 1:
            buttonLabel.setTitle("Sign Up", for: .normal)
            confirmPasswordLabel.isHidden = false
            confirmPasswordTextField.isHidden = false
            statusLabel.text = ""
        default:
            break
        }
        
    }

}
