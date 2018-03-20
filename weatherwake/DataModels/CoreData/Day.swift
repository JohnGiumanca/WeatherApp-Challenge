//
//  Day.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import CoreData

class Day: NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var name: String!
}
