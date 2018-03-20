//
//  NotificationsWrapper.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 01/04/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class NotificationsWrapper: NSObject {
    private static let ALARM_ID = "alarm_id"

    private static let ALARM_CATEGORY = "alarm_category"
    static let SNOOZE_ACTION = "snooze_action"
    
    private static let SNOOZE_INTERVAL = 30 // 30 seconds
    
    static func scheduleNotifications(_ alarm:Alarm, dates:[Date]) {
        for date in dates {
            let isRecurring = alarm.days.count > 0
            let notification = createNotification(alarm, date: date, isRecurring: isRecurring)
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
    
    static func scheduleSnoozedNotification(_ notification: UILocalNotification) {
        let date = notification.fireDate!
        let snoozeDate = date.addingTimeInterval(Double(SNOOZE_INTERVAL))
        
        let snoozeNotification = duplicateNotification(notification)
        snoozeNotification.fireDate = snoozeDate
        UIApplication.shared.scheduleLocalNotification(snoozeNotification)
    }
    
    static func cancelNotifications(_ alarm:Alarm) {
        let notifications = getNotifications(alarm)
        
        for notification in notifications {
            UIApplication.shared.cancelLocalNotification(notification)
        }
    }
    
    static func hasNotifications(_ alarm:Alarm) -> Bool {
        let notifications = getNotifications(alarm)
        
        return notifications.count > 0
    }
    
    static func getNotifications(_ alarm:Alarm) -> [UILocalNotification]{
        var alarmNotifications = [UILocalNotification]()
        
        let notifications = UIApplication.shared.scheduledLocalNotifications
        
        if (notifications == nil) {
            return alarmNotifications
        }
        
        for notification in notifications! {
            let alarmId = notification.userInfo![ALARM_ID] as! String
            if (alarmId == alarm.id) {
                alarmNotifications.append(notification)
            }
        }
        
        return alarmNotifications
    }
    
    static func duplicateNotification(_ triggeredNotification: UILocalNotification) -> UILocalNotification {
        let notification = UILocalNotification()
        notification.alertBody = triggeredNotification.alertBody
        notification.userInfo = triggeredNotification.userInfo
        notification.timeZone = triggeredNotification.timeZone
        notification.soundName = triggeredNotification.soundName
        notification.category = triggeredNotification.category
        
        return notification
    }
    
    static func createNotification(_ alarm:Alarm, date:Date, isRecurring:Bool) -> UILocalNotification {
        let notification = UILocalNotification()
        
        notification.fireDate = date;
        notification.alertBody = alarm.name
        notification.userInfo = [ALARM_ID: alarm.id]
        notification.timeZone = TimeZone.current
        notification.soundName = alarm.sound
        notification.category = ALARM_CATEGORY
        
        if (isRecurring) {
            notification.repeatInterval = NSCalendar.Unit.day
        }
        
        return notification
    }
    
    static func registerForNotifications() {
        let notificationCategory = createNotificationsCategory()
        let notificationSettings = UIUserNotificationSettings(types: [.alert , .sound, .badge], categories: Set(arrayLiteral: notificationCategory))
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
    }
    
    static func createNotificationsCategory() -> UIMutableUserNotificationCategory {
        let snoozeAction = UIMutableUserNotificationAction()
        snoozeAction.identifier = SNOOZE_ACTION
        snoozeAction.title = "Snooze"
        snoozeAction.activationMode = UIUserNotificationActivationMode.background
        snoozeAction.isAuthenticationRequired = false
        snoozeAction.isDestructive = true
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = ALARM_CATEGORY
        category.setActions([snoozeAction], for: UIUserNotificationActionContext.minimal)
        category.setActions([snoozeAction], for: UIUserNotificationActionContext.default)
        
        return category
    }
}
