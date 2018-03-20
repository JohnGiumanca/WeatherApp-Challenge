//
//  AlertHelper.swift
//  weatherwake
//
//  Created by Bogdan Dumitrescu on 4/2/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class AlertHelper : NSObject {
    
    class func createAlert(_ title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        return alert
    }
    
}
    
