//
//  AlarmDA.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import Foundation

class AlarmDA: BaseDA {
    private let DEFAULT_ALARM_NAME = "Untitled"
    private let DEFAULT_SOUND = "SuperRingtone.caf"
    
    override init() {
        super.init()
        entityName = "Alarm"
    }
    
    func createAlarm() -> Alarm {
        let alarm = super.create() as! Alarm
        alarm.id = UUID().uuidString
        alarm.name = DEFAULT_ALARM_NAME
        alarm.sound = DEFAULT_SOUND

        return alarm
    }
    
    func getAllAlarms() -> [Alarm] {
        return super.fetchObjects(nil, sortDescriptors: nil) as! [Alarm]
    }
    
    func getAlarm(_ id:String) -> Alarm? {
        let predicate = NSPredicate(format: "self.id = %@", id)
        let alarms = super.fetchObjects(predicate, sortDescriptors: nil)
        return alarms.first as! Alarm?
    }
    
    func deleteAlarm(_ alarm:Alarm) {
        super.deleteObject(alarm)
        super.save()
    }
    
    func deleteAllAlarms() {
        super.deleteObjects(getAllAlarms())
        super.save()
    }

}
