//
//  User.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 19/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var iD: Int = 0
    var email: String? = nil
    var password: String = ""
    var UID: Int = 0
    var name: String = ""
    var phone: String? = nil
    var username: String? = nil
    var image: String? = nil
    var address: String? = nil
    var birthday: String? = nil
    var facebookID: String? = nil
    var googleID: String? = nil
    var feedback: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case iD = "id"
        case email
        case password
        case UID = "uid"
        case name
        case phone
        case username
        case image
        case address
        case birthday
        case facebookID = "f_id"
        case googleID = "g_id"
        case feedback
    }
}


// MARK: - Verify User

struct VerifyUserResponse: Codable {
    
    let number: Int
    var isExist: Bool {
        return number > 0
    }
    
    enum CodingKeys: String, CodingKey {
        case number
    }
}


// MARK: - UpdateSocialUserResponse User

struct UpdateSocialUserResponse: Codable {
    
    let error: String
    var isUpdated: Bool {
        return error.lowercased() == "false"
    }
    
}


// MARK: - LoginSocialUserResponse User

struct LoginSocialUserResponse: Codable {
    
    let iD: Int
    
    enum CodingKeys: String, CodingKey {
        case iD = "id"
    }
}

