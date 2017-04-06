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
    var password: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var userInfo: NSDictionary?
    
    init(userInfo: NSDictionary) {
        self.username = userInfo["username"] as? String
        self.password = userInfo["password"] as? String
        self.userInfo = userInfo as NSDictionary
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let savedUser = defaults.object(forKey: "savedUser") as? Data
                if let savedUser = savedUser {
                    let dict = try! JSONSerialization.jsonObject(with: savedUser as Data, options: [])
                    _currentUser = User(userInfo: dict as! NSDictionary)
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
