//
//  NavigationController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 19/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    public func addGradientToNavigationBar(colors: [UIColor]) {
        let gradient = CAGradientLayer()
        var bounds = navigationBar.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        
        if let image = UIImage.image(from: gradient) {
            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    
}
