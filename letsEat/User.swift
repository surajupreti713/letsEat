//
//  User.swift
//  letsEat
//
//  Created by Prashant Bhandari on 3/29/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var username: String?
//    var password: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var userInfo: NSDictionary?
    
    init(currentUserInfo: NSDictionary) {
        self.username = currentUserInfo["username"] as? String
        // we don't need the password
//        self.password = currentUserInfo["password"] as? String
        self.email = currentUserInfo["email"] as? String
        self.firstName = currentUserInfo["firstName"] as? String
        self.lastName = currentUserInfo["lastName"] as? String
        self.userInfo = currentUserInfo as NSDictionary
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let savedUser = defaults.object(forKey: "savedUser") as? Data
                if let savedUser = savedUser {
                    let dict = try! JSONSerialization.jsonObject(with: savedUser as Data, options: [])
                    _currentUser = User(currentUserInfo: dict as! NSDictionary)
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: (user.userInfo)!, options: [])
                defaults.set(data, forKey: "savedUser")
                print("current user saved")
            }
            else {
                defaults.removeObject(forKey: "savedUser")
            }
            defaults.synchronize()
        }
    }

}
