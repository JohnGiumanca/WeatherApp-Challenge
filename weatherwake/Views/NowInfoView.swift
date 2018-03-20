//
//  NowInfoView.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 01/04/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class NowInfoView: UIView {
    
    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var temperatureLabel: UILabel?
    @IBOutlet var locationLabel: UILabel?
    
    @IBOutlet var conditionImageView: UIImageView?
    
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
        temperatureLabel?.text = condition.getTemperature()

        let conditionImageName = WeatherConditionTypeEnum.getIconName(condition.condition)
        conditionImageView?.image = UIImage(named: conditionImageName)
    }
    
    @objc func loadDateAndTime() {
        let date = Date()
        
        let time = DateConverter.getTime(date)
        let day = DateConverter.getDay(date)
        
        timeLabel?.text = time
        dateLabel?.text = day
    }
}
