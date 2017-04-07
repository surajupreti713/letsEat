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
class profileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageLabel: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        let currentUser = User.currentUser
        nameLabel.text = "\((currentUser?.firstName)!) \((currentUser?.lastName)!)"
        // temprary image just for testing
        let tempProfileImage: UIImage = profileImage ?? UIImage(named: "test_profile_pic")!
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
    
    
    @IBAction func profilePictureTapped(_ sender: UITapGestureRecognizer) {
        let alertViewController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        alertViewController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.openCamera()
        }))
        alertViewController.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (_) in
            self.openPhotoGallery()
        }))
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        else {
            let alertViewController = UIAlertController(title: "Oops!", message: "Couldn't find Camera", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    func openPhotoGallery() {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImage = editedImage
            profileImageLabel.image = editedImage
            SaveProfilePictureToDisk.saveProfilePicture(profilePicture: profileImage)
            dismiss(animated: true, completion: nil)
        }
        else {
            let alertViewController = UIAlertController(title: "Oops!", message: "Something went wrong while getting the image", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    
}
