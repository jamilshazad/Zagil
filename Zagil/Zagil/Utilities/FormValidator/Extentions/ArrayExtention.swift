//
//  ArrayExtention.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

extension Array where Element == ValidationType {
    
    
    // MARK: - Public Methods
    
    func shouldChange(characters: String, text: String, lenght: Int) -> Bool {
        var result = true
        
        for rule in self {
            switch rule {
            case .alphanumeric:
                result = result && ValidationRegex.alphanumeric.validate(string: characters)
            case .max(let max):
                result = result && max >= lenght
            case .cardExpiration:
                result = result && checkExpiration(text: text, newText: characters, length: lenght)
            case .creditcard:
                result = result && lenght < 20
            case .phone:
                result = result && lenght < 15
            case .pincode:
                result = result && ValidationRegex.pincode.validate(string: characters)
            default:
                break
            }
        }
        
        return result
    }
    
    
    // MARK: - Private Methods
    
    private func checkExpiration(text: String, newText: String, length: Int) -> Bool {
        if newText.isEmpty {
        } else if text.count == 0 {
            return "01".contains(newText)
        } else if length == 1 {
            if text == "0" {
                return "123456789".contains(newText)
            } else {
                return "012".contains(newText)
            }
        }
        
        return length < 6
    }
}
