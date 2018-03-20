//
//  SpectrumImageView.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 01/04/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class SpectrumImageView: UIImageView {
    private let SPECTRUM_IMAGE = "spectrum_"
    private let SPECTRUM_DURATION = 2.0
    
    func startAnimatingSpectrum() {
        let animatedImage = UIImage.animatedImageNamed(SPECTRUM_IMAGE, duration: SPECTRUM_DURATION)
        self.image = animatedImage
    }
    
    func stopAnimatingSpectrum() {
        self.image = nil
    }
}
