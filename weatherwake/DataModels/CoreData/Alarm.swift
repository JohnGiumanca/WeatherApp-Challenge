//
//  Alarm.swift
//  
//
//  Created by Andrei Vasilescu on 31/03/16.
//
//

import CoreData

class Alarm: NSManagedObject {
    @NSManaged var id: String!
    
    @NSManaged var name: String!
    @NSManaged var sound: String!
    @NSManaged var date: Date!
    @NSManaged var isOn: NSNumber!
    
    @NSManaged var days: Set<Day>!
}
