//
//  NotificationsScheduler.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class NotificationsScheduler: NSObject {
    static func scheduleAlarm(_ alarm:Alarm) {
        removeAlarm(alarm)
        
        let alarmDates = computeAlarmOccurences(alarm)
        NotificationsWrapper.scheduleNotifications(alarm, dates: alarmDates)
    }
    
    static func removeAlarm(_ alarm:Alarm) {
        NotificationsWrapper.cancelNotifications(alarm)
    }
    
    static private func computeAlarmOccurences(_ alarm:Alarm) -> [Date] {
        let (hour, minute) = extractTimeFromDate(alarm.date as Date)

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        var alarmDates = [Date]()
        
        if (alarm.days.count <= 0) {
            let alarmDate = computeFirstAlarmOccurence(dateComponents)
            
            alarmDates.append(alarmDate)
            
            return alarmDates
        } else {
            for day in alarm.days {
                // ids start from 0(Monday) to 6(Sunday) and calendar days are from 1(Sunday) to 7(Saturday)
                let weekday = (day.id.intValue + 1) % 7 + 1
                dateComponents.weekday = weekday
                
                let alarmDate = computeFirstAlarmOccurence(dateComponents)
                
                alarmDates.append(alarmDate)
            }
            
            return alarmDates
        }
    }
    
    static private func computeFirstAlarmOccurence(_ dateConstraints: DateComponents) -> Date {
        let calendar = Calendar.current
        let result: Date = (calendar as NSCalendar).nextDate(after: Date(), matching: dateConstraints, options: NSCalendar.Options.matchNextTime)!

        return result
    }
    
    static private func extractTimeFromDate(_ date:Date) -> (Int, Int) {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "HH"
        let hour = Int(dateFormatter.string(from: date))!
        
        dateFormatter.dateFormat = "mm"
        let minute = Int(dateFormatter.string(from: date))!
        
        return (hour, minute)
    }
}
