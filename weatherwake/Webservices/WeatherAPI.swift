//
//  WeatherAPI.swift
//  weatherwake
//
//  Created by Bogdan Dumitrescu on 4/1/16.
//  Copyright © 2016 mready. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class WeatherAPI : BaseAPI {
    
    let WEATHER_API_PATH = "weather"
    let FORECAST_API_PATH = "forecast"
    let APPID = "8c81c350710733b1e90609c3a17e3175"
    let UNITS = "METRIC"
    
    func requestWeather(_ location: CLLocation,
                         success:@escaping (WeatherCondition)->(),
                         failure:@escaping (String)->()) {
        let url: String = BASE_URL + WEATHER_API_PATH
        
        
        let params: [String: Any] = ["lat": "\(location.coordinate.latitude)",
                                           "lon": "\(location.coordinate.longitude)",
                                           "units": UNITS,
                                           "APPID": APPID]

        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default)
            .responseJSON { (response) in
                if (super.isFailure(response: response, failure: failure)) {
                    return
                }
                
                let responseJson = response.result.value as! [String: AnyObject]
                let weather: WeatherCondition = WeatherCondition(json: responseJson)
                
                success(weather)
        }
    }
    
}
