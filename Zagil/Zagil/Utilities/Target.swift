//
//  Target.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

enum Target: String {
    case live = "Live"
    
    
    // MARK: - Properties
    
    static var current: Target {
        return live
    }
}
