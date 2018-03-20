//
//  AppDelegate.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        DayDA.createWeekdaysIfNecessary()
        NotificationsWrapper.registerForNotifications()
        AlarmManager.disableExpiredAlarms()
        
        if (launchOptions != nil) {
            NotificationsHandler.didOpenNotification(window!)
        }

        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        NotificationsHandler.didOpenNotification(window!)
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        NotificationsHandler.didSelectSnoozeOnNotification(notification)
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, withResponseInfo responseInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        NotificationsHandler.didSelectSnoozeOnNotification(notification)
    }

}

