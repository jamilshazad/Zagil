//
//  Window.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

public enum SwapVCAnimation {
    case push
    case pop
    case present
    case dismiss
}

extension UIWindow {
    
    func swapRoot(viewController:UIViewController,
                  animation: SwapVCAnimation,
                  completion: EmptyCompletion? = nil) {
        
        rootViewController = viewController
        
        let options: AnimationOptions = .curveEaseOut
        let duration: TimeInterval = 0.3
        
        switch animation {
        case .push:
            viewController.view.frame = CGRect(x: width, y: 0, width: width, height: height)
        case .pop:
            viewController.view.frame = CGRect(x: -width, y: 0, width: width, height: height)
        case .present:
            viewController.view.frame = CGRect(x: 0, y: height, width: width, height: height)
        case .dismiss:
            viewController.view.frame = CGRect(x: 0, y: -height, width: width, height: height)
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            viewController.view.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        }) { _ in
            completion?()
        }
    }
    
}
