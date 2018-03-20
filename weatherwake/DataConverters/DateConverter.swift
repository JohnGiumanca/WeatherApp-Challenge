//
//  DateConverter.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import Foundation

class DateConverter {
    // MARK: Constants
    static let TIME_FORMAT = "HH:mm"
    static let DAY_FORMAT = "EEE, MMMM dd"
    static let HOUR_FORMAT = "HH"
    
    // MARK: Static Methods
    // Extracts time from a NSDate object
    static func getTime(_ date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = TIME_FORMAT
        
        return formatter.string(from: date)
    }
    
    static func getDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DAY_FORMAT
        
        return formatter.string(from: date)
    }
    
    static func getHour(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = HOUR_FORMAT
        
        return formatter.string(from: date)
    }
}
