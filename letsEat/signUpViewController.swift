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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//signUpSegue
    
    //TODO: find out a way to include first name and last name of the user, so that fist name could
    // be displayed later. maybe PFObject can be used to store the user information.
    @IBAction func signUpButtonPressed(_ sender: Any) {
        if (usernameTextLabel.text == nil) {
            let alertViewController = UIAlertController(title: "error", message: "username missing", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true, completion: nil)
        }
            
        else if (passwordTextLabel.text == nil) {
            let alertViewController = UIAlertController(title: "error", message: "Password missing", preferredStyle: .alert)
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
                    let alertController = UIAlertController(title: "Success!", message: "You have successfully created an Instagram account", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                    self.performSegue(withIdentifier: "signUpSegue", sender: nil)
                } else {
                    print(error?.localizedDescription)
                }
            }
            
        }
    }
}
