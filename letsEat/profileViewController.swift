//
//  profileViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 3/29/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import Parse


// TODO: maybe you shoud try and implement the resturent an user has visited in this
// view listed in a table view.
class profileViewController: UIViewController {

    @IBOutlet weak var profileImageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "some ramdom Name that may poop up"
        // temprary image just for testing
        let tempProfileImage: UIImage = UIImage(named: "test_profile_pic")!
        profileImageLabel.image = tempProfileImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        PFUser.logOutInBackground { (logoutError: Error?) in
            if logoutError == nil {
                User.currentUser = nil
                NotificationCenter.default.post(name: NSNotification.Name(NotificationKeys.logoutKey), object: self)
            }
            else {
                 print("error logging out")
            }
        }
    }
}
