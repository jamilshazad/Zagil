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
    
    func convertTimestamp(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium

        return  getElapsedInterval(chatDate: date as Date)
    }
    
    func getElapsedInterval(chatDate: Date ) -> String {
        
        // From Time
        let fromDate = chatDate
        
        // To Time
        let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }
        
        return "a moment ago"
    }
        
    
}
