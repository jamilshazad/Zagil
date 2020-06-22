//
//  StringExtention.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Public Methods
    
    func formatPhoneNumber() -> String {
        if count == 0 {
            return ""
        }
        let newString: String = (self as NSString).replacingCharacters(in: (self as NSString).range(of: self), with: self)
        let components: [Any] = newString.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let decimalString: String = (components as NSArray).componentsJoined(by: "")
        
        
        let length: Int = decimalString.count
        var index: Int = 0
        var formattedString = String()
        if length - index > 3 {
            let areaCode: String = (decimalString as NSString).substring(with: NSRange(location: index, length: 3))
            formattedString += "(\(areaCode))"
            index += 3
        }
        if length - index > 3 {
            let prefix: String = (decimalString as NSString).substring(with: NSRange(location: index, length: 3))
            formattedString += " \(prefix)-"
            index += 3
        }
        let startIndex = decimalString.index(decimalString.startIndex, offsetBy: index)
        let remainder = String(decimalString[startIndex...])
        formattedString.append(remainder)
        return formattedString
    }
}
