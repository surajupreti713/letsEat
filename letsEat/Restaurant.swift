//
//  Restaurant.swift
//  letsEat
//
//  Created by Suraj Upreti on 4/9/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import MapKit

class Restaurant: NSObject, MKAnnotation {
    let title: String?
    let location: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.location = locationName
        //self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return location
    }
}
