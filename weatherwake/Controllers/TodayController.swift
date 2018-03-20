//
//  TodayController.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 01/04/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit
import CoreLocation

class TodayController: BaseController {
    
    @IBOutlet weak var todayViewInfo: TodayViewInfo!
    var locationManager: LocationManager?
    
    override func viewWillAppear(_ animated: Bool) {
        
        locationManager = LocationManager(controller: self, handler: { (location) in
            self.updateWeatherState(location)
        })
        locationManager!.requestLocation()
    }
    
    func updateWeatherState(_ location: CLLocation) {
        let weatherAPI: WeatherAPI = WeatherAPI()
        
        let myLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude )
        
        
        weatherAPI.requestWeather(myLocation, success: { (weather) in
            self.updateWeatherCondition(weather)
        }) { (error) in
            let apiErrorAlert = AlertHelper.createAlert("API Error", message: "The weather API doesn't respond, the app may not be fully functional.")
            self.present(apiErrorAlert, animated: true, completion: nil)
        }
    }
    
    func updateWeatherCondition(_ condition: WeatherCondition) {
        todayViewInfo.loadWeatherCondition(condition)
    }
    
    
    
    
    
    
    
}
