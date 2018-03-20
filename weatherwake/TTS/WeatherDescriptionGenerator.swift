//
//  SpeechGenerator.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 01/04/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class WeatherDescriptionGenerator: NSObject {
    static func generateConditionsDescription(_ conditions: [WeatherCondition]) -> String {
        var description = "Hi! Here's today's forecast!\n"
        
        for condition in conditions {
            description += generateDescription(condition)
            description += "\n"
        }
        
        return description
    }
    
    static func generateDescription(_ condition: WeatherCondition) -> String {
        var description = "Starting with " + DateConverter.getHour(condition.date) + " o' clock "
        
        description += getConditionDescription(condition.condition)
        description += "Max temperature will be \(condition.temperature) degrees celsius"
        
        return description
    }
    
    static func getConditionDescription(_ conditionType: WeatherConditionType) -> String {
        switch conditionType {
        case .Clear:
            return "the sky will be clear."
        case .FewClouds, .OvercastClouds:
            return "there will be a few clouds."
        case .ScatteredClouds, .BrokenClouds:
            return "clouds are expected."
        case .Mist:
            return "misty weather is coming up ahead."
        case .Shower:
            return "expect a light shower."
        case .LightRain:
            return "a bit of rain is expected."
        case .Rain:
            return "rain is expected."
        case .Storm:
            return "beware of the upcoming storm."
        case .Snow:
            return "expect snow."
        }
    }
}
