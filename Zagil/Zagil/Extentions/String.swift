//
//  String.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Class Properties
    
    var normalize: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    // MARK: - Piblic Methods
    
    func toDate(format: DateFormatType, ignoreTimeZone: Bool = false) -> Date? {
        return format.getFormatter(ignoreTimeZone: ignoreTimeZone).date(from: self)
    }
    
    func getCurrencyOfString() ->String {
        var currency = "";
        
        if(self == "United States - USD (US$)"){
            currency = "USD"
        } else if(self == "Canadian Dollar - CAD (C$)"){
            currency = "CUD"
        }
        else if (self == "EURO - EUR (€)") {
            currency = "EUR"
        }
        else if (self == "Japanese yen - JPY (¥)") {
            currency = "JPY"
        }
        else if (self == "British Pound - GBP (£)") {
            currency = "GBP"
        }
        else if (self == "Australian Dollar - AUD (A$)") {
            currency = "AUD"
        }
        else if (self == "Brazil Real - BRL (R$)") {
            currency = "BRL"
        }
        else if (self == "Hong Knong Dollar - HKD (HK$)") {
            currency = "HKD"
        }
        else if (self == "Swedish Krona - SEK (kr)"){
            currency = "KR"
        }
        else if (self == "NewZeland Dollar - NZD (NZ$)"){
            currency = "NZD"
        }
        else if(self == "Singapore Dollar - SGD (S$") {
            currency = "SGD"
        }
        else if(self == "Indian Rupee - INR (₹)") {
            currency = "INR"
        }
        else if(self == "Pakistan Rupee - PKR (RS)"){
            currency = "PKR"
        }
        else if(self == "Saudia Riyal - SAR (﷼)"){
            currency = "SAR"
        }
        else if(self == "Chinese Yaun - CHE(¥)") {
            currency = "CHE"
        }
        return currency
        
    }
    
}
