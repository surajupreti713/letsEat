//
//  NotificationSender.swift
//  letsEat
//
//  Created by Prashant Bhandari on 4/9/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import Parse

class NotificationSender: NSObject {
    
    class func send(to: String, from: String) {
        let notifyQuery = PFQuery(className: "invitation_by_\(to)")
        notifyQuery.getObjectInBackground(withId: "Id_\(to)") { (invitation: PFObject?, error: Error?) in
            if let invitation = invitation {
                invitation["requested"] = true
                invitation["guest"] = "\((User.currentUser?.username)!)"
                invitation.saveInBackground()
            }
            else {
                print("error_while_sending_request: \((error?.localizedDescription)!)")
            }
        }
    }
    
    class func createInviation() {
        let invitation = PFObject(className: "invitation_by_\((User.currentUser?.username)!)")
        invitation["requested"] = false
        invitation["guest"] = "none" // username
        invitation.objectId = "Id_\((User.currentUser?.username)!)"
        invitation.saveInBackground { (success :Bool, error: Error?) in
            if let error = error {
                print("error: \(error.localizedDescription)")
            }
            
            else {
                print("invitation successfully posted")
            }
        }
    }

}
