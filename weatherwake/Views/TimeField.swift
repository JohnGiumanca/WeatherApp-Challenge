//
//  TimeField.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class TimeInputField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()

        configureInputView()
    }
    
    // MARK: Public methods
    @objc func dismissInputView() {
        self.resignFirstResponder()
    }
    
    // Preloads a given date
    func loadDate(_ date:Date) {
        setTimeText(date)
        setPickerDate(date)
    }
    
    func getSelectedDate() -> Date {
        let datePicker = self.inputView as! UIDatePicker
        return datePicker.date
    }
    
    // Method triggerd when a time is selected in the picker input
    @objc func didSelectDate(_ datePicker:UIDatePicker) {
        setTimeText(datePicker.date)
    }
    
    // MARK: Private methods
    private func setTimeText(_ date:Date) {
        let timeString = DateConverter.getTime(date)
        self.text = timeString
    }
    
    private func setPickerDate(_ date:Date) {
        let datePicker = self.inputView as! UIDatePicker
        datePicker.date = date
    }
    
    // Configures the input as a PickerView
    private func configureInputView() {
        setPickerInputView()
        setAccessoryInputView()
    }
    
    // Sets a spinning picker as input source for the text field
    private func setPickerInputView() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.locale = Locale(identifier:"RO")
        datePicker.addTarget(self, action: #selector(didSelectDate), for: UIControlEvents.valueChanged)
        
        self.inputView = datePicker
    }
    
    // Sets a Toolbar with a "Done" button on the input view
    private func setAccessoryInputView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        toolbar.barStyle = UIBarStyle.default
        
        toolbar.items = [UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissInputView))]
        
        self.inputAccessoryView = toolbar
    }
}
