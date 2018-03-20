//
//  SpeechPlayer.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 01/04/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechReader: NSObject {
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func read(_ speech: String) {
        let utterance = AVSpeechUtterance(string: speech)
        
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.15
        
        speechSynthesizer.speak(utterance)
    }
    
    func stop() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
}
