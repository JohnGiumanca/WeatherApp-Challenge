//
//  AlarmDetailsController.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class AlarmDetailsController: BaseController {
    // MARK: UI Elements
    @IBOutlet var activeSwitch: UISwitch!
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var weekdaysSelectorView: WeekdaysSelectorView!
    @IBOutlet var timeTextField: TimeInputField!
    
    // MARK: Constants
    let alarmDA = AlarmDA()
    
    // MARK: Variables
    var alarm:Alarm?
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAlarmDetails()
    }

    private func loadAlarmDetails() {
        if (alarm == nil) {
            loadAlarmPlaceholder()
        } else {
            loadAlarm()
        }
    }
    
    private func loadAlarmPlaceholder() {
        let nowDate = Date()
        timeTextField.loadDate(nowDate)
    }
    
    private func loadAlarm() {
        nameTextField.text = alarm!.name
        
        timeTextField.loadDate(alarm!.date)
        
        let selectedDays = DayConverter.getIds(Array(alarm!.days))
        weekdaysSelectorView.selectDays(selectedDays)
        
        setIsOn(alarm!.isOn)
    }
    
    private func createNewAlarm() {
        alarm = alarmDA.createAlarm()
    }
    
    private func saveAlarm() {
        alarm!.date = timeTextField.getSelectedDate()
        
        if ((nameTextField.text?.count ?? 0) > 0) {
            alarm!.name = nameTextField.text
        }
        
        alarm!.isOn = getIsOn()
        alarm!.days = getSelectedDays()
        
        NotificationsScheduler.scheduleAlarm(alarm!)
        
        alarmDA.save()
    }
    
    private func deleteAlarm() {
        NotificationsScheduler.removeAlarm(alarm!)
        
        alarmDA.deleteAlarm(alarm!)
    }
    
    private func getSelectedDays() -> Set<Day> {
        let ids = weekdaysSelectorView.getSelectedDays()
        let dayDA = DayDA()
        
        return Set(dayDA.getDays(ids))
    }
    
    private func getIsOn() -> NSNumber! {
        return NSNumber(value: activeSwitch.isOn as Bool)
    }
    
    private func setIsOn(_ isOn: NSNumber) {
        activeSwitch.isOn = isOn.boolValue
    }
    
    // MARK: UI Actions
    @IBAction private func onDoneTapped() {
        if (alarm == nil) {
            createNewAlarm()
        }
        
        saveAlarm()
        
        goBack()
    }
    
    @IBAction private func onRemoveTapped() {
        if (alarm != nil) {
            deleteAlarm()
        }
        
        goBack()
    }
    
    @IBAction private func onBackgroundTapped() {
        self.view.endEditing(true)
    }
}
