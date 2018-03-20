//
//  DayDA.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import Foundation

class DayDA: BaseDA {
    static func createWeekdaysIfNecessary() {
        let dayDA = DayDA()

        if (!dayDA.hasDays()) {
            dayDA.createDays()
        }
    }
    
    override init() {
        super.init()
        entityName = "Day"
    }
    
    func getAllDays() -> [Day] {
        return super.fetchObjects(nil, sortDescriptors: nil) as! [Day]
    }
    
    func getDay(_ id:NSNumber) -> Day? {
        let predicate = NSPredicate(format: "self.id = %@", id)
        let days = super.fetchObjects(predicate, sortDescriptors: nil)
        
        return days.first as! Day?
    }
    
    func getDays(_ ids:[NSNumber]) -> [Day] {
        let predicate = NSPredicate(format: "self.id IN %@", ids)
        let days = super.fetchObjects(predicate, sortDescriptors: nil)
        
        return days as! [Day]
    }
    
    private func hasDays() -> Bool {
        let days = getAllDays()
        
        return days.count > 0
    }
    
    private func createDays() {
        for weekday in Weekdays.all {
            let day = create() as! Day
            let dayIndex = Weekdays.all.index(of: weekday)!

            day.id = NSNumber(value: dayIndex as Int)
            day.name = weekday.rawValue
        }
        
        save()
    }
}
