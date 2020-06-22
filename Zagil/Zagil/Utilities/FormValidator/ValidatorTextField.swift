//
//  ValidatorTextField.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ValidatorTextField: UITextField {
    
    // MARK: - Class Properties
    
    public var hasError: Bool = false {
        didSet {
            layer.borderColor = hasError ? UIColor.red.cgColor : UIColor.lightGray.cgColor
        }
    }
}
