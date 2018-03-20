//
//  AlarmCell.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

protocol AlarmCellDelegate {
    func didChangeAlarmState(_ alarm:Alarm, isOn:Bool)
}

class AlarmCell: UITableViewCell {
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var activeSwitch: UISwitch!
    @IBOutlet var daysLabel: UILabel!
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    var delegate: AlarmCellDelegate?
    private var alarm: Alarm?
    
    func loadAlarm(_ alarm:Alarm) {
        self.alarm = alarm
        
        titleLabel.text = alarm.name
        timeLabel.text = DateConverter.getTime(alarm.date)
        activeSwitch.isOn = alarm.isOn.boolValue
        if(alarm.days.count > 0){
            if(alarm.days.count == 7){
                daysLabel.text = "Daily"
            }
            else{
                daysLabel.text = ""
                for day in alarm.days{
                    let indexEndOfText = day.name.index(day.name.startIndex, offsetBy: 3)
                    daysLabel.text = daysLabel.text! + " " + String(day.name[..<indexEndOfText]).capitalized
                }
                
            }
        }
        else{
            daysLabel.text = ""
        }
        
       
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundImageView.isHighlighted = highlighted
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundImageView.isHighlighted = selected
    }
    
    @IBAction func switchStateChanged() {
        delegate?.didChangeAlarmState(alarm!, isOn: activeSwitch.isOn)
    }
}
