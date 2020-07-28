//
//  SenderFeed.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct SenderFeed: Codable {
    
    var iD: Int = 0
    var name: String = ""
    var UID: Int = 0
    var source: String = ""
    var destination: String = ""
    var weight: String = ""
    var weightUnit: String? = nil
    var size: String = ""
    var sizeUnit: String = ""
    var description: String = ""
    var price: String = ""
    var priceUnit: String = ""
    
    enum CodingKeys: String, CodingKey {
        case iD = "id"
        case name
        case UID = "uid"
        case source
        case destination
        case weight
        case weightUnit
        case size
        case sizeUnit
        case description
        case price
        case priceUnit
    }
}



