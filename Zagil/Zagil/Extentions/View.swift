//
//  View.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

@objc
enum GradientDirection: Int {
    case horizontal
    case vertical
}

extension UIView {

    
    // MARK: - Class Properties
    
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }

    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    
    // MARK: - Public Methods
    
    @discardableResult
    func applyGradient(colours: [UIColor], direction: GradientDirection = .horizontal) -> CAGradientLayer {
        return applyGradient(colours: colours, locations: nil, direction: direction)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, direction: GradientDirection = .horizontal) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colours.map { $0.cgColor }
        if direction == .horizontal {
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            gradient.locations = locations
        }
        layer.name = "Gradient"
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func removeGradient() {
        layer.sublayers?.removeAll { $0.name == "Gradient" }
    }
    
}
