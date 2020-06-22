//
//  ConfigurationManager.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

class ConfigurationManager: NSObject {
    
    
    // MARK: - Initiaization Methods
    
    private override init() {
        super.init()
    }
    
    
    // MARK: - Public Methods
    
    class func value<T>(for key: ConfigurationKey) -> T {
        let configurations = dictionary()
        guard let dictionary = configurations[key.rawValue] as? [String : T],
            let value = dictionary[Target.current.rawValue] else {
                assertionFailure(R.string.localizable.keyNotFound())
                // App should already sent as assertion before reaching this statement
                return "" as! T
        }
        
        return value
    }
    
    
    // MARK: - Private Methods
    
    private class func dictionary() -> NSDictionary {
        guard let path = Bundle.main.path(forResource: R.string.localizable.configurations(), ofType: R.string.localizable.plist()) else {
            assertionFailure(R.string.localizable.configurationNotFound())
            return [:]
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: path) else {
            assertionFailure(R.string.localizable.dictionaryNotFound())
            return [:]
        }
        
        return dictionary
    }
}


// MARK: - Configuration Keys

enum ConfigurationKey: String {
    case baseUrl = "BASE_URL"
    case googleClientID = "GOOGLE_CLIENT_ID"
    case googleApiKey = "GOOGLE_API_KEY"
}

struct Constants {
    static let currencyDataSource = ["United States - USD (US$)","EURO - EUR (€)","Japanese yen - JPY (¥)","British Pound - GBP (£)","Australian Dollar - AUD (A$)","Canadian Dollar - CAD (C$)","Brazil Real - BRL (R$)","Hong Knong Dollar - HKD (HK$)","Swedish Krona - SEK (kr)",
    "NewZeland Dollar - NZD (NZ$)",
    "Singapore Dollar - SGD (S$)",
    "Indian Rupee - INR (₹)",
    "Pakistan Rupee - PKR (RS)",
    "Saudia Riyal - SAR (ریال;(",
    "Chinese Yaun - CHE(¥)"]
}
