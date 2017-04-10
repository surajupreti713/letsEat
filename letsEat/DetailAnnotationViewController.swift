//
//  DetailAnnotationViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 4/10/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit

class DetailAnnotationViewController: UIViewController {
    
    var host: String?
    @IBOutlet weak var hostNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hostNameLabel.text = host
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
