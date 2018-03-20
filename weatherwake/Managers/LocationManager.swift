//
//  LocationManager.swift
//  weatherwake
//
//  Created by Bogdan Dumitrescu on 4/1/16.
//  Copyright © 2016 mready. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    var clientController: UIViewController!
    var updateLocationHandler:((CLLocation)->Void)!
    
    init(controller: UIViewController, handler: @escaping (_ location: CLLocation)->()) {
        self.clientController = controller
        self.updateLocationHandler = handler
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
        } else {
            self.requestPermission()
        }
    }
    
    func requestPermission() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            
            locationManager.startUpdatingLocation()
        }
        
        if CLLocationManager.authorizationStatus() == .restricted ||
            CLLocationManager.authorizationStatus() == .denied {
            let alertController = UIAlertController(
                title: "Location Access Disabled",
                message: "In order to get the weather forecast for your location, we need access to the location services!",
                preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let url = URL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(url)
                }
            }
            alertController.addAction(openAction)
            
            self.clientController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locations.count > 0) {
            let userLocation:CLLocation = locations.last!
                
            if (updateLocationHandler != nil) {
                updateLocationHandler(userLocation)
                
                updateLocationHandler = nil
                locationManager.stopUpdatingLocation()
            }
        }
    }
    
}
