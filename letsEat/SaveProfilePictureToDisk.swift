//
//  SaveProfilePictureToDisk.swift
//  letsEat
//
//  Created by Prashant Bhandari on 4/7/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import Parse

class SaveProfilePictureToDisk: NSObject {
    
    class func saveProfilePicture(profilePicture: UIImage?) {
        let profileImage = PFObject(className: "ProfilePicture_\((User.currentUser?.username)!)")
        if let imagePFFile = getPFFileFromImage(image: profilePicture) {
            profileImage["image"] = imagePFFile
        }
        profileImage.saveInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print("error while saving the profile picture: \(error.localizedDescription)")
            }
        }
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    

}
