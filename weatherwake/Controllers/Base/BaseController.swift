//
//  BaseController.swift
//  weatherwake
//
//  Created by Andrei Vasilescu on 31/03/16.
//  Copyright © 2016 mready. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTransparentNavigationBar()
        setTitleAttributes()
        
        // Removes back button text, leaving only the white arrow
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // Removes navigation bar background and shadow
    func setTransparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    // Sets title font, size and color
    func setTitleAttributes() {
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                          NSAttributedStringKey.font: Fonts.regularFont(17.0)] as [NSAttributedStringKey : Any]
        
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
