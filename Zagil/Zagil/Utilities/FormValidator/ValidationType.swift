//
//  ValidationType.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

enum ValidationType {
    case regex(regex: ValidationRegex)
    case multipleregex(regexes: [ValidationRegex])
    case max(characters: Int)
    case min(characters: Int)
    case matches(object: ValidationObject)
    case cardExpiration
    case creditcard
    case notempty
    case phone
    case alphanumeric
    case pincode
    
    
    // MARK: Properties
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .cardExpiration, .creditcard, .phone, .pincode:
            return .numberPad
        case .regex(let regex):
            return regex.keyboardType
        default:
            return .default
        }
    }
    
    var isPhoneNumber: Bool {
        switch self {
        case .phone: return true
        default: return false
        }
    }
    
     
    
    // MARK: Public Methods
    
    func validate(on textField: ValidatorTextField) -> Bool {
        let text = textField.text ?? ""
        switch self {
        case .regex(let regex): return regex.validate(string: text)
        case .multipleregex(let regexes):
            var valid = false
            regexes.forEach { valid = valid || $0.validate(string: text) }
            return valid
        case .max(let characters): return characters >= text.count
        case .min(let characters): return characters <= text.count
        case .matches(let object): return text == object.textField.text
        case .cardExpiration: return text.count > 4
        case .creditcard: return text.count > 15
        case .notempty: return !text.isEmpty
        case .phone: return text.count > 13
        case .alphanumeric: return true
        case .pincode: return text.count == 4 || text.count == 6
        }
    }
    
}
