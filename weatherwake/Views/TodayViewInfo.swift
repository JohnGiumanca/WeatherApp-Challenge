//
//  TodayViewInfo.swift
//  weatherwake
//
//  Created by John Giumanca on 20/03/2018.
//  Copyright © 2018 mready. All rights reserved.
//

import UIKit

class TodayViewInfo: UIView {

    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var locationLabel: UILabel?
    
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initDateTimer()
        loadDateAndTime()
    }
    
    func initDateTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(loadDateAndTime), userInfo: nil, repeats: true)
    }
    
    func loadWeatherCondition(_ condition: WeatherCondition) {
        locationLabel?.text = condition.city
        
    }
    
    @objc func loadDateAndTime() {
        let date = Date()
        
        let time = DateConverter.getTime(date)
        let day = DateConverter.getDay(date)
        
        timeLabel?.text = time
        dateLabel?.text = day
    }
}


