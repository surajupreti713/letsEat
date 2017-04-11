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
    
    
    // this method is called everytime a user requests to be at an invitation.
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
    
    
    // create an invitation in the disk as an object which will later be queried in the MapView and presented.
    class func createInviation(business: Business, successfull:  @escaping ()->(), failure:  @escaping (Error)->()) {
        let invitation = PFObject(className: "invitation")
        invitation["host"] = "\((User.currentUser?.username)!)"
        invitation["requested"] = false
        invitation["guest"] = "none" // username
        invitation["venue"] = "\((business.name)!)"
        invitation["longitude"] = "\((business.longitude)!)"
        invitation["latitude"] = "\((business.latitude)!)"
        invitation["address"] = business.address
        invitation["restaurantImage"] = "\((business.imageURL)!)"
        invitation["categories"] = "\((business.categories)!)"
        invitation["ratingImage"] = "\((business.ratingImageURL)!)"
        invitation["reviews"] = "\((business.reviewCount)!)"
        invitation.saveInBackground { (success :Bool, error: Error?) in
            if let error = error {
                print("error creating invitation: \(error.localizedDescription)")
                failure(error)
            }
            else {
                print("invitation successfully posted")
                successfull()
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
