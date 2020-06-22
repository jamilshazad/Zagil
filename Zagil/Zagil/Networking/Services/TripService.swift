//
//  TripService.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Moya

enum TripService: ServiceType {
    
    // MARK: - Services
    
    case getTrips(iD: String, date: String)
    case addTrip(iD: String, from: String, to: String, date: String, weight: String, weightUnit: String, size: String, sizeUnit: String, description: String, price: String, priceUnit: String)
    case getPostedTrips(iD: String)
    case deletePostedTrip(iD: String, UID: String)
    case updatePostedTrip(iD: String, UID: String, weight: String, weightUnit: String, size: String, sizeUnit: String, description: String, price: String, priceUnit: String)
    
    
    // MARK: - Configuration
    
    var path: String {
        switch self {
        case .getTrips: return "trips/getTrip"
        case .addTrip: return "trip/addTrip"
        case .getPostedTrips: return "getTrip/posted"
        case .deletePostedTrip: return "deletePostedTrip"
        case .updatePostedTrip: return "updatePostedTripDetail"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTrips, .getPostedTrips: return .get
        case .addTrip, .deletePostedTrip, .updatePostedTrip: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getTrips(let iD, let date):
            let params = ["id": iD,
                          "date" : date]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .addTrip(let iD, let from, let to, let date, let weight, let weightUnit, let size, let sizeUnit, let description, let price, let priceUnit):
            let params = ["uid" : iD,
                          "source" : from,
                          "destination" : to,
                          "date" : date,
                          "weight" : weight,
                          "weightUnit" : weightUnit,
                          "size" : size,
                          "sizeUnit" : sizeUnit,
                          "description" : description,
                          "price" : price,
                          "priceUnit" : priceUnit,
                          "version" : ""]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getPostedTrips(let iD):
            let params = ["uid" : iD,
                          "status" : "posted"]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .deletePostedTrip(let iD, let UID):
            let params = ["id" : iD,
                          "uid" : UID]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .updatePostedTrip(let iD, let UID, let weight, let weightUnit, let size, let sizeUnit, let description, let price, let priceUnit):
            let params = ["id" : iD,
                          "uid" : UID,
                          "weight" : weight + " " + weightUnit,
                          "size" : size + " " + sizeUnit,
                          "description" : description,
                          "price" : price + " " + priceUnit]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var authorizationType: AuthorizationType? { return nil }
}
