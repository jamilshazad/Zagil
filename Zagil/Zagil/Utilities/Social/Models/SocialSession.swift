//
//  SocialSession.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 26/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

public struct SocialSession {
    
    
    // MARK: - Properties
    
    public var token: String
    public var user: SocialUser
    public var additionalInfo: [String : Any]
}
