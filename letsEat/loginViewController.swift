//
//  loginViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 3/28/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import Parse


class loginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let userName = usernameTextField.text
        let password = passwordTextField.text
        let userInfo: [String:String] = ["username": userName!, "password": password!]
        User.currentUser = User(userInfo: userInfo as NSDictionary)
        PFUser.logInWithUsername(inBackground: userName!, password: password!) { (logedInUser: PFUser?, loginError: Error?) in
            if let loginError = loginError {
                print(loginError.localizedDescription)
                let error = loginError.localizedDescription
                let alertViewController = UIAlertController(title: "LogIn Error", message: error, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertViewController.addAction(okAction)
                self.present(alertViewController, animated: true, completion: nil)
            }
            else {
                print("successfully logged In")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }

    
//signUpButtonPressed function created by Prashant
    
//    @IBAction func signUpButtonPressed(_ sender: Any) {
//        let newUser = PFUser()
//        newUser.username = usernameTextField.text
//        newUser.password = passwordTextField.text
//        newUser.signUpInBackground { (successfulSignin: Bool, signUpError: Error?) in
//            if let signUpError = signUpError {
//                print(signUpError.localizedDescription)
//                let error = signUpError.localizedDescription
//                let alertViewController = UIAlertController(title: "SignUp Error", message: error, preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alertViewController.addAction(okAction)
//                self.present(alertViewController, animated: true, completion: nil)
//            }
//            else {
//                print("Successfully Signed Up New User")
//                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
//            }
//        }
//        
//    }
    


}
