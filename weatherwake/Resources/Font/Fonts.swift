//
//  Fonts.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class Fonts: NSObject {
    static func lightFont(_ size:CGFloat) -> UIFont! {
        return UIFont(name: "Roboto-Light", size: size)
    }
    
    static func regularFont(_ size:CGFloat) -> UIFont! {
        return UIFont(name: "Roboto", size: size)
    }
    
    static func thinFont(_ size:CGFloat) -> UIFont! {
        return UIFont(name: "Roboto-Thin", size: size)
    }
}
