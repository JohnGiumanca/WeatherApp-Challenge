//
//  AlarmManager.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 01/04/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class AlarmManager: NSObject {
    static func disableExpiredAlarms() {
        let alarmDA = AlarmDA()
        let alarms = alarmDA.getAllAlarms()
        
        for alarm in alarms {
            if !NotificationsWrapper.hasNotifications(alarm) {
                alarm.isOn = NSNumber(value: false as Bool)
            }
        }
        
        alarmDA.save()
    }
}
