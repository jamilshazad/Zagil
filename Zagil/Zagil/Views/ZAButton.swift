//
//  ZAButton.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

@objc
enum ZAButtonType: Int {
    case rounded
    case flat
}

@IBDesignable
class ZAButton: UIButton {

    
    // MARK: - Class Properties
    
    @IBInspectable
    public var shape: ZAButtonType = .rounded {
        didSet {
            commonInit()
        }
    }
    
    @IBInspectable
    public var disableColor: UIColor = .clear {
        didSet {
            commonInit()
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            commonInit()
        }
    }
    
    public var isGradient: Bool = false {
        didSet {
            commonInit()
        }
    }
    
    
    // MARK: - Initialization Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    
    // MARK: - Private Methods
    
    private func commonInit() {
        if shape == .flat {
            cornerRadius = 0
        }
        titleLabel?.font = .bold()
        if isGradient && isEnabled {
            applyGradient(colours: [R.color.darkGreen()!, R.color.lightGreen()!])
        } else {
            backgroundColor = disableColor
        }
    }

}
