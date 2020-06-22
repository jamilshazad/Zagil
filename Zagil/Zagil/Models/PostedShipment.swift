//
//  PostedShipment.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 02/05/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct PostedShipment: Codable {
    
    var iD: Int = 0
    var type: String = ""
    var weight: String = ""
    var weightUnit: String = ""
    var size: String = ""
    var sizeUnit: String = ""
    var price: String = ""
    var priceUnit: String = ""
    var description: String = ""
    var receiverName: String = ""
    var receiverPhone: String = ""
    var source: String = ""
    var destination: String = ""
    var date: String = ""
    var UID: Int = 0
    var status: String = ""
    var version: String? = nil
    var name: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case iD = "id"
        case type
        case weight
        case weightUnit = "weightunit"
        case size
        case sizeUnit
        case price
        case priceUnit
        case description
        case receiverName
        case receiverPhone
        case source
        case destination
        case date
        case UID = "uid"
        case status
        case version
        case name
    }
}


// MARK: - DeletePostedShipmentResponse

struct DeletePostedShipmentResponse: Codable {
    
    let error: String
    var isDeleted: Bool {
        return error.lowercased() == "false"
    }
    
}


// MARK: - UpdatePostedShipmentResponse

struct UpdatePostedShipmentResponse: Codable {
    
    let error: String
    var isUpdated: Bool {
        return error.lowercased() == "false"
    }
    
}
