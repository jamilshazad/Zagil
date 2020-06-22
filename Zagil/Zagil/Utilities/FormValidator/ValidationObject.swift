//
//  ValidationObject.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ValidationObject {
    
    
    // MARK: - Class Properties
    
    public var textField: ValidatorTextField
    public var rules: [ValidationType]
    public var shouldReturn: Bool
    
    
    // MARK: - Initialization Methods
    
    init(textField: ValidatorTextField, rules: ValidationType..., defaultReturn: Bool = true) {
        self.textField = textField
        self.rules = rules
        self.shouldReturn = defaultReturn
    }
    
    
    // MARK: - Public Methods
    
    public func isValid() -> Bool {
        guard !rules.isEmpty else {
            textField.hasError = true
            return true
        }
        
        guard let text = textField.text, !text.isEmpty else {
            textField.hasError = false
            return false
        }
        
        for rule in rules {
            if !rule.validate(on: textField) {
                textField.hasError = textField.isEditing
                return false
            }
        }
        
        // Can Add Profinity Filter Here
        
        textField.hasError = false
        return true
    }
    
}
