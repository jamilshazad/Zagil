//
//  PostedTrip.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 02/05/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct PostedTrip: Codable {
    
    var iD: Int = 0
    var UID: Int = 0
    var source: String = ""
    var destination: String = ""
    var weight: String = ""
    var weightUnit: String = ""
    var size: String = ""
    var sizeUnit: String = ""
    var price: String = ""
    var priceUnit: String = ""
    var description: String = ""
    var startDate: String = ""
    var endDate: String = ""
    var status: String = ""
    //var tsID: String = ""
    var version: String? = nil
    var name: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case iD = "id"
        case UID = "uid"
        case source
        case destination
        case weight
        case weightUnit
        case size
        case sizeUnit
        case price
        case priceUnit
        case description
        case startDate = "date"
        case endDate = "endDate"
        //case tsID = "ts_id"
        case version
        case name
    }
}


// MARK: - DeletePostedTripResponse

struct DeletePostedTripResponse: Codable {
    
    let error: String
    var isDeleted: Bool {
        return error.lowercased() == "false"
    }
    
}


// MARK: - UpdatePostedTripResponse

struct UpdatePostedTripResponse: Codable {
    
    let error: String
    var isUpdated: Bool {
        return error.lowercased() == "false"
    }
    
}
