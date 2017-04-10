//
//  RestaurantDetailsViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 4/9/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categorylabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setImageWith((business?.imageURL)!)
        nameLabel.text = business?.name
        addressLabel.text = business?.address
        categorylabel.text = business?.categories
        ratingImageView.setImageWith((business?.ratingImageURL)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func organizeButtonPressed(_ sender: Any) {
        NotificationSender.createInviation(business: business!)
    }
}
