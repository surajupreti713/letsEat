//
//  DetailAnnotationViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 4/10/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import Parse

class DetailAnnotationViewController: UIViewController {
    
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var restautantImage: UIImageView!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    
    var businesses: [PFObject]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let business = businesses?[0]
        restaurantLabel.text = business?.object(forKey: "venue") as? String
        restautantImage.setImageWith(URL(string: business?.object(forKey: "restaurantImage") as! String)!)
        restaurantAddress.text = business?.object(forKey: "address") as? String
        category.text = business?.object(forKey: "categories") as? String
        ratingImage.setImageWith(URL(string: business?.object(forKey: "ratingImage") as! String)!)
        reviews.text = business?.object(forKey: "reviews") as? String
        hostLabel.text = String("Organized by: \((business?.object(forKey: "host") as? String)!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requestButton(_ sender: Any) {
        NotificationSender.sendRequest(to: (businesses?[0].object(forKey: "host") as? String)!, from: "\((User.currentUser?.username)!)")
    }
}
