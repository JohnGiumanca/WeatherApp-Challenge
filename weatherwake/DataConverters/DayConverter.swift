//
//  DaysConverter.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import Foundation

class DayConverter {
    static let SHORT_DAY_LENGTH = 3
    
    static func getIds(_ days:[Day]) -> [NSNumber] {
        var ids = [NSNumber]()
        
        for day in days {
            ids.append(day.id)
        }
        
        return ids
    }
    
    static func getScheduledDays(_ days:[Day]) -> String {
        let scheduledDays = getWeekdays(days)
        
        let weekPeriod = WeekdaysIdentifier.getWeekPeriod(scheduledDays)
        
        if (weekPeriod != nil) {
            return weekPeriod!.rawValue.capitalized
        } else {
            return serializeDays(scheduledDays)
        }
    }
    
    static func shortDayName(_ dayName: String) -> String {
        let index = dayName.index(dayName.startIndex, offsetBy: SHORT_DAY_LENGTH)
        
        return String(dayName[..<index])
    }
    
    private static func getWeekdays(_ days:[Day]) -> [Weekdays] {
        var weekdays = [Weekdays]()
        
        for day in days {
            let dayIndex = day.id.intValue
            weekdays.append(Weekdays.all[dayIndex])
        }
        
        return weekdays
    }
    
    private static func serializeDays(_ days:[Weekdays]) -> String {
        var dayNames = [String]()
        
        for day in Weekdays.all {
            if (days.contains(day)) {
                let shortName = shortDayName(day.rawValue.capitalized)
                dayNames.append(shortName)
            }
        }
        
        let daysString = dayNames.joined(separator: ", ")
        
        return daysString
    }
}
