//
//  WeatherConditionType.swift
//  weatherwake
//
//  Created by Bogdan Dumitrescu on 4/1/16.
//  Copyright © 2016 mready. All rights reserved.
//

import Foundation

enum WeatherConditionType: String {
    case Clear = "clear sky"
    case FewClouds = "few clouds"
    case ScatteredClouds = "scattered clouds"
    case BrokenClouds = "broken clouds"
    case OvercastClouds = "overcast clouds"
    case Mist = "mist"
    case Shower = "shower rain"
    case Rain = "rain"
    case LightRain = "light rain"
    case Storm = "thunderstorm"
    case Snow = "snow"
}

class WeatherConditionTypeEnum {
    
    static func getIconName(_ conditionType: WeatherConditionType) -> String {
        switch conditionType {
        case .Clear:
            return "icon_w_s"
        case .FewClouds, .OvercastClouds:
            return "icon_w_cs"
        case .ScatteredClouds, .BrokenClouds:
            return "icon_w_c"
        case .Shower, .Rain, .LightRain, .Storm:
            return "icon_w_cr"
        case .Snow:
            return "icon_w_cw"
        case .Mist:
            return "icon_w_s"
        }
    }
}
