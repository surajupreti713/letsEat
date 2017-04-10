//
//  mapViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 3/29/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class mapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!

//    var business: Business!
    var invitationArray: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        getInvitationsFromDisk()
    }
    
    // was intitally gonna user this function to get the current location of user,
    // but iphone amulator in mac always shows San Fransesco while get location from gps.
    @IBAction func getCurrentLocation(_ sender: Any) {
            
            let mapCenter = CLLocationCoordinate2D(latitude: 38.936001, longitude: -77.037916)
            let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
            // Set animated property to true to animate the transition to the region
            mapView.setRegion(region, animated: true)
    }
    
    // this method gets all the invitation from the database created by, NotificationSender.createInvitation.
    func getInvitationsFromDisk() {
        let invitationQuery = PFQuery(className: "invitation")
        invitationQuery.whereKey("requested", equalTo: false)
        invitationQuery.findObjectsInBackground { (respondArray: [PFObject]?, error: Error?) in
            if let respondArray = respondArray {
                print("respond invitation Array: \(respondArray)")
                self.invitationArray = respondArray
                self.displayInvitationsAnnotations()
            }
            else {
                print("error while quering for invitaion in MapView: \((error?.localizedDescription)!)")
            }
        }
    }
    
    
    // this function loops through all the annotation in the annotation array 
    // and pin them in the map.
    func displayInvitationsAnnotations() {
        if let invitationArray = invitationArray {
            for invitation in invitationArray {
                let latitude = Double((invitation.object(forKey: "latitude") as? String)!)
                let longitude = Double((invitation.object(forKey: "longitude") as? String)!)
                let annotation = MKPointAnnotation()
                let locationCoordinate = CLLocationCoordinate2D(latitude: latitude! , longitude: longitude!)
                annotation.coordinate = locationCoordinate
                annotation.title = invitation.object(forKey: "host") as? String
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    
    // this function is called after the annotation is tapped
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation {
            if let title = annotation.title! {
                print("Tapped \(title) pin")
            }
        }
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
