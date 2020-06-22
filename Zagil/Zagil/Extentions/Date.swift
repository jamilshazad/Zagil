//
//  Date.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

extension Date {
    
    func getString(of type: DateFormatType, addTimeZone: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        
        if addTimeZone {
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        
        formatter.dateFormat = type.getFormat()
        return formatter.string(from: self)
    }
    
}

enum DateFormatType {
    case MMMM_dd
    case dd_MM_YYYY
    case EEEE_MMM_d_yyyy
    
    func getFormat() -> String {
        switch self {
        case .MMMM_dd: return "MMMM dd"
        case .dd_MM_YYYY: return "dd/MM/YYYY"
        case .EEEE_MMM_d_yyyy: return "EEEE, MMM d, yyyy"
        }
    }
    
    func getFormatter(ignoreTimeZone: Bool = false) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if ignoreTimeZone == false  {
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        formatter.dateFormat = getFormat()
        return formatter
    }

}
