//
//  AuthorizeError.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 26/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

public enum AuthorizeError: Error {
    case provider
    case network
    case parse
    case accounts
    case cancel
    case custom(Error)
}


// MARK: - Localized Errors

extension AuthorizeError: LocalizedError {
    
    public var localizedDescription: String {
        switch self {
        case .network: return "There is bad network response."
        case .parse: return "There is something wrong while parsing of network response."
        case .custom(let error): return error.localizedDescription
        default: return ""
        }
    }
    
}
