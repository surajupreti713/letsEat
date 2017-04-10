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
    
    class func sendRequest(to: String, from: String) {
        getObjectId(invitingUser: to, success: { (objectId: String) in
            let notifyQuery = PFQuery(className: "invitation")
            notifyQuery.whereKey("host", equalTo: to)
            notifyQuery.getObjectInBackground(withId: "\(objectId)") { (invitation: PFObject?, error: Error?) in
                if let invitation = invitation {
                    invitation["requested"] = true
                    invitation["guest"] = "\((User.currentUser?.username)!)"
                    invitation.saveInBackground()
                    print("*****")
                    print("request send")
                }
                else {
                    print("error while sending request: \((error?.localizedDescription)!)")
                }
            }
        }) { (error: Error) in
            print("error while getting the objectId: \(error.localizedDescription)")
        }
    }
    
    class func createInviation() {
        let invitation = PFObject(className: "invitation")
        invitation["host"] = "\((User.currentUser?.username)!)"
        invitation["requested"] = false
        invitation["guest"] = "none" // username
        invitation["longitude"] = "-77.037916"
        invitation["latitude"] = "38.936001"
        invitation.saveInBackground { (success :Bool, error: Error?) in
            if let error = error {
                print("error creating invitation: \(error.localizedDescription)")
            }
            else {
                print("invitation successfully posted")
            }
        }
    }
    
    // this function takes in a closure and call then with objectId passed as parameter.
    class func getObjectId(invitingUser: String, success: @escaping (String) -> (), failure: @escaping (Error)->()) {
        print("invitation successfully posted")
        let query = PFQuery(className: "invitation_by_\((invitingUser))")
        query.whereKey("requested", equalTo: false)
        query.order(byDescending: "createdAt")
        query.limit = 1
        
        /*
         *TODO: Try and catch this warning and desplay some message
         *      "Warning: `BFTask` caught an exception in the continuation block."
         *      "This behavior is discouraged and will be removed in a future release. "
         *      "Caught Exception: *** -[__NSArray0 objectAtIndex:]: index 0 beyond bounds for empty NSArray"
         *      This warning occured when the invitation object's request key already has value TRUE.
         */
        
        query.findObjectsInBackground(block: { (respondArray: [PFObject]?, error: Error?) in
            if let error = error {
                failure(error)
            }
            else {
                success((respondArray?[0].objectId)!)
            }
        })
    }

}
