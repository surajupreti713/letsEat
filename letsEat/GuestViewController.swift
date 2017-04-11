//
//  GuestViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 4/11/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import Parse

class GuestViewController: UIViewController {

    @IBOutlet weak var guestLabel: UILabel!
    
    var guest: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let guest = guest {
//            guestLabel.text = guest
//        }
//        else {
//            let alertViewController = UIAlertController(title: nil, message: "Just a sec", preferredStyle: .alert)
//            alertViewController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
//                self.viewDidLoad()
//            }))
//            present(alertViewController, animated: true, completion: nil)
//        }
        // timer that calls the method that is assigned to it in certain interval
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(GuestViewController.onTimer), userInfo: nil, repeats: true)
        onTimer()
    }

    func onTimer() {
        let query = PFQuery(className: "invitation")
        query.whereKey("requested", equalTo: true)
        query.whereKey("host", equalTo: "\((User.currentUser?.username)!)")
        query.whereKey("guest", notEqualTo: "none")
        query.order(byDescending: "createdAt")
        query.limit = 1
        
        query.findObjectsInBackground(block: { (respondArray: [PFObject]?, error: Error?) in
            if let respondArray = respondArray {
                self.guest = respondArray[0].object(forKey: "guest") as? String
                self.guestLabel.text = self.guest
                self.view.reloadInputViews()
            }
            else {
                print("error while loading invitaion data: \((error?.localizedDescription)!)")
            }
        })
    }
    
    @IBAction func DoneButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
