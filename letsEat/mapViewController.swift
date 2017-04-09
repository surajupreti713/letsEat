//
//  mapViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 3/29/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var business: Business!
    
    let regionRadius: CLLocationDistance = 1000
    
    //helps to zoom the pin
    //The location argument is the center point. The region will be have north-south and east-west spans based on a distance of regionRadius – you set this to 1000 meters (1 kilometer), which is a little more than half a mile. You then use regionRadius * 2.0 here, because that works well for plotting the data
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets the initial location of the restaurant
        let initialLocation = CLLocation(latitude: business.latitude!, longitude: business.longitude!)
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        //show artwork on map
        let artwork = Restaurant(title: business.name!, locationName: business.address!, coordinate: CLLocationCoordinate2D(latitude: business.latitude!, longitude: business.longitude!))
        mapView.addAnnotation(artwork)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
