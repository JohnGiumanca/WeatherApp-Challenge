//
//  BaseAPI.swift
//  weatherwake
//
//  Created by Bogdan Dumitrescu on 4/1/16.
//  Copyright © 2016 mready. All rights reserved.
//

import Foundation
import Alamofire

class BaseAPI: NSObject {
    
    internal let BASE_URL = "http://api.openweathermap.org/data/2.5/"
 
    internal func isFailure(response: DataResponse<Any>, failure: (_ error: String) -> ()) -> Bool {
        if response.result.value == nil {
            failure("No internet connection available")
            return true
        }
        
        if (response.response!.statusCode == 401) {
            failure("Authentication expired")
            return true
        }
        
        return false
    }
    
}
