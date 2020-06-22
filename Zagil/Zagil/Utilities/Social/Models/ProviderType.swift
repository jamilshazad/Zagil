//
//  ProviderType.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 26/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

public enum ProviderType {
    case facebook
    case google
    case apple
    
    var description: String {
        switch self {
        case .facebook: return "Facebook"
        case .google: return "Google"
        case .apple: return "Apple"
        }
    }
}
