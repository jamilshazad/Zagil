//
//  ZATextField.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

@IBDesignable
class ZATextField: ValidatorTextField {
    
    // MARK: - Class Properties
    
    @IBInspectable
    public var leftIcon: UIImage? {
        didSet {
            commonInit()
        }
    }

    @IBInspectable
    public var iconPadding: CGFloat = 0
    
    @IBInspectable
    public var iconTintColor: UIColor? = nil
    
    @IBInspectable
    public var placeholderColor: UIColor? = nil {
        didSet {
            commonInit()
        }
    }
    
    override var hasError: Bool {
        didSet {
            layer.borderColor = hasError ? UIColor.red.cgColor : R.color.darkGreen()!.cgColor
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
    
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += iconPadding
        rect.size.width += iconPadding + 5
        return rect
    }
    
    
    // MARK: - Private Methods
    
    private func commonInit() {
        if let image = leftIcon {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            if let iconTintColor = iconTintColor {
                imageView.tintColor = iconTintColor
            }
            leftView = imageView
        } else {
            leftViewMode = .never
            leftView = nil
        }
        
        if let placeholderColor = placeholderColor, let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : placeholderColor])
        }
        
    }
}
