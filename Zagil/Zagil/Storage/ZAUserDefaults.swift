//
//  ZAUserDefaults.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct ZAUserDefaults {
    static var email = UserDefaultObject<String>(key: "Email")
    static var password = UserDefaultObject<String>(key: "Password")
    static var user = UserDefaultObject<User>(key: "User")
    static var token = UserDefaultObject<String>(key: "token")

}
