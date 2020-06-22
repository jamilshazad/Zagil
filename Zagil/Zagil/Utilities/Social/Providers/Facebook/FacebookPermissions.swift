//
//  FacebookPermissions.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 26/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

public enum FacebookPermission: CaseIterable {
    case id
    case profile
    case email
    case firstName
    case lastName
    case birthday
    
    var description: String {
        switch self {
        case .id: return "id"
        case .profile: return "public_profile"
        case .email: return "email"
        case .firstName: return "first_name"
        case .lastName: return "last_name"
        case .birthday: return "birthday"
        }
    }
}
