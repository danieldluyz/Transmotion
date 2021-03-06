//
//  LocalizationController.swift
//  TransMotion
//
//  Created by Daniel D'luyz O on 11/04/15.
//  Copyright (c) 2015 com.transmotion. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class LocalizationController: UIViewController, CLLocationManagerDelegate  {
    
    var manager: CLLocationManager?
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.delegate = self;
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func getLocation(sender: AnyObject) {
        let available = CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion)
        manager?.requestWhenInUseAuthorization()
        manager?.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        manager.stopUpdatingLocation()
        let location = locations[0] as! CLLocation
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (data, error) -> Void in
            let placeMarks = data as! [CLPlacemark]
            let loc: CLPlacemark = placeMarks[0]
            
            self.mapView.centerCoordinate = location.coordinate
            self.mapView.showsUserLocation = true
            let regionRadius: CLLocationDistance = 1000
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                regionRadius * 2.0, regionRadius * 2.0)
            self.mapView.setRegion(coordinateRegion, animated: true)
            
            self.latitude = Double(location.coordinate.latitude)
            //self.latitud = NSString(string: latitude).doubleValue
            
            self.longitude = Double(location.coordinate.longitude)
            //self.longitud = NSString(string: longitude).doubleValue
        })
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("\(error)")
    }
    
    @IBAction func irAMenu(sender: AnyObject) {
        performSegueWithIdentifier("welcomeSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "welcomeSegue"{
            let welcomeController = segue.destinationViewController as! WelcomeController
            welcomeController.latitude = self.latitude
            welcomeController.longitude = self.longitude
        }
        
    }
}
