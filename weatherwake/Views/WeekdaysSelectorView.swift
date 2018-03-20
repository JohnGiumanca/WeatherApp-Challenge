//
//  WeekdaysSelectorView.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class WeekdaysSelectorView: UIView {
    // MARK: UI elements
    @IBOutlet private var dayButtons:[UIButton]?
    
    // MARK: Public Methods
    func getSelectedDays() -> [NSNumber] {
        var selectedDays = Array<NSNumber>()
        
        for button in dayButtons! {
            if (button.isSelected) {
                selectedDays.append(NSNumber(value: button.tag as Int))
            }
        }

        return selectedDays
    }
    
    func selectDays(_ days:[NSNumber]) {
        for button in dayButtons! {
            if (days.contains(NSNumber(value: button.tag))) {
                button.isSelected = true
            }
        }
    }
    
    // MARK: Logic
    private func configureButtonFont(_ button:UIButton) {
        let fontSize = button.titleLabel?.font.pointSize
        
        if (button.isSelected) {
            button.titleLabel?.font = Fonts.regularFont(fontSize!)
        } else {
            button.titleLabel?.font = Fonts.lightFont(fontSize!)
        }
    }
    
    // MARK: UI Actions
    @IBAction private func onDayTapped(_ button:UIButton) {
        button.isSelected = !button.isSelected
        configureButtonFont(button)
    }
}
