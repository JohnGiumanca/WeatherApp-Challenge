//
//  NotificationsHandler.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 01/04/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class NotificationsHandler: NSObject {
    static func didSelectSnoozeOnNotification(_ notification: UILocalNotification) {
        NotificationsWrapper.scheduleSnoozedNotification(notification)
    }
    
    static func didOpenNotification(_ window: UIWindow) {
        NavigationManager.openTodayController(window)
    }
}
