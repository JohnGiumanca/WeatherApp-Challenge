//
//  Weekdays.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

enum Weekdays: String {
    case Monday = "monday"
    case Tuesday = "tuesday"
    case Wednesday = "wednesday"
    case Thursday = "thursday"
    case Friday = "friday"
    case Saturday = "saturday"
    case Sunday = "sunday"
    
    case WeekdaysTitle = "weekdays"
    case DailyTitle = "daily"
    case WeekendTitle = "weekend"
    
    static let all = [Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday]
    static let weekdays = Set([Monday, Tuesday, Wednesday, Thursday, Friday])
    static let daily = Set(all)
    static let weekends = Set([Saturday, Sunday])
}

class WeekdaysIdentifier {
    static func getWeekPeriod(_ days:[Weekdays]) -> Weekdays? {
        let daysSet = Set(days)
        
        if (daysSet == Weekdays.weekdays) {
            return Weekdays.WeekdaysTitle
        }
        
        if (daysSet == Weekdays.daily) {
            return Weekdays.DailyTitle
        }
        
        if (daysSet == Weekdays.weekends) {
            return Weekdays.WeekendTitle
        }
        
        return nil
    }
}
