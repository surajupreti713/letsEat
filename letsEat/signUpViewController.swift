//
//  signUpViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 3/29/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import Parse

class signUpViewController: UIViewController {

    @IBOutlet weak var emailTextLabel: UITextField!
    @IBOutlet weak var usernameTextLabel: UITextField!
    @IBOutlet weak var passwordTextLabel: UITextField!
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNamelabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //TODO: Change the order of the if statements to match the order of the text fields.
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        // if else condition to check if any of the text field is empty,
        // if anyone is empty a alert message will poop with error message.
        if (usernameTextLabel.text?.isEmpty ?? true) {
            let alertViewController = UIAlertController(title: "error", message: "username missing", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true, completion: nil)
        }
            
        else if (passwordTextLabel.text?.isEmpty ?? true) {
            let alertViewController = UIAlertController(title: "error", message: "Password missing", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true, completion: nil)
        }
            
        else if (emailTextLabel.text?.isEmpty ?? true) {
            let alertViewController = UIAlertController(title: "error", message: "Email missing", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true, completion: nil)
        }
        
        else if (firstNameLabel.text?.isEmpty ?? true) {
            let alertViewController = UIAlertController(title: "error", message: "First name missing", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true, completion: nil)
        }
        
        else if (lastNamelabel.text?.isEmpty ?? true) {
            let alertViewController = UIAlertController(title: "error", message: "Last name missing", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true, completion: nil)
        }

        else {
            let newUser = PFUser()
            newUser.username = usernameTextLabel.text
            newUser.email = emailTextLabel.text
            newUser.password = passwordTextLabel.text
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if success {
                    print("Yay, created a user!")
                    
                    // saving the sighning in user as current user
                    var currentUserInfo: [String:String] = [:]
                    currentUserInfo["username"] = self.usernameTextLabel.text
                    currentUserInfo["email"] = self.emailTextLabel.text
                    currentUserInfo["firstName"] = self.firstNameLabel.text
                    currentUserInfo["lastName"] = self.lastNamelabel.text
                    User.currentUser = User(currentUserInfo: currentUserInfo as NSDictionary)
                    
                    // Info of the user to be save for later use
                    let userInfo = PFObject(className: "UserInfo")
                    userInfo["username"] = self.usernameTextLabel.text
                    userInfo["email"] = self.emailTextLabel.text
                    userInfo["firstName"] = self.firstNameLabel.text
                    userInfo["lastName"] = self.lastNamelabel.text
                    userInfo.saveInBackground(block: { (success: Bool, error: Error?) in
                        if let error = error {
                            print("error while saving userInfor: \(error.localizedDescription)")
                        }
                        else {
                            print("Success: userInfo successfully saved")
                        }
                    })
                    
                    // alert message after a new User is successfully created.
                    let alertController = UIAlertController(title: "Success!", message: "You have successfully created an letsEat account", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
                    })
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                else {
                    print((error?.localizedDescription)!)
                    
                    // alertView that will be displayed if there is an error while singup a new User
                    let alertViewController = UIAlertController(title: "error", message: "\((error?.localizedDescription)!)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertViewController.addAction(okAction)
                    self.present(alertViewController, animated: true, completion: nil)
                }
            }
            
        }
    }
}
