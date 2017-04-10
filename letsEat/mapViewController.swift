//
//  mapViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 3/29/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var business: Business!
//    var locationManager = CLLocationManager()
    
//    var currentLatitude: CLLocationDegrees?
//    var currentLongitude: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
//        initLocation()
    }
    
    @IBAction func getCurrentLocation(_ sender: Any) {
        
//        if self.currentLatitude != nil {
//            self.locationManager.delegate = nil
//            print("location: \((self.currentLatitude)!) \((self.currentLongitude)!)")
            
            let mapCenter = CLLocationCoordinate2D(latitude: 38.936001, longitude: -77.037916)
            let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
            // Set animated property to true to animate the transition to the region
            mapView.setRegion(region, animated: true)
            
//        }
    }
    
//    func initLocation() {
//        self.locationManager.requestAlwaysAuthorization()
//        self.locationManager.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            self.locationManager.delegate = self
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            self.locationManager.startUpdatingLocation()
//        }
//    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0]
//        let long = userLocation.coordinate.longitude
//        let lat = userLocation.coordinate.latitude
//        self.currentLatitude = lat
//        self.currentLongitude = long
////        print("location: \(long) \(lat)")
//    }

    

}
