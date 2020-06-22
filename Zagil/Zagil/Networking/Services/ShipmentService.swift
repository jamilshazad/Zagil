//
//  ShipmentService.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Moya

enum ShipmentService: ServiceType {
    
    // MARK: - Services
    
    case getShipments(iD: String, date: String)
    case addShipment(iD: String, type: String, recieverName: String, recieverPhone: String, from: String, to: String, date: String, weight: String, weightUnit: String, size: String, sizeUnit: String, description: String, price: String, priceUnit: String)
    case getPostedShipments(iD: String)
    case deletePostedShipment(iD: String, UID: String)
    case updatePostedShipment(iD: String, UID: String, weight: String, weightUnit: String, size: String, sizeUnit: String, description: String, price: String, priceUnit: String)
    
    
    // MARK: - Configuration
    
    var path: String {
        switch self {
        case .getShipments: return "shipment/getShipment"
        case .addShipment: return "shipment/addShipment"
        case .getPostedShipments: return "getShipment/posted"
        case .deletePostedShipment: return "deletePostedShipment"
        case .updatePostedShipment: return "updatePostedShipmentDetail"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getShipments, .getPostedShipments: return .get
        case .addShipment, .deletePostedShipment, .updatePostedShipment: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getShipments(let iD, let date):
            let params = ["id": iD,
                          "date" : date]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .addShipment(let iD, let type, let recieverName, let recieverPhone, let from, let to, let date, let weight, let weightUnit, let size, let sizeUnit, let description, let price, let priceUnit):
            let params = ["uid" : iD,
                          "type": type,
                          "receiverName": recieverName,
                          "receiverPhone": recieverPhone,
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
            
        case .getPostedShipments(let iD):
            let params = ["uid" : iD,
                          "status" : "posted"]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .deletePostedShipment(let iD, let UID):
            let params = ["id" : iD,
                          "uid" : UID]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .updatePostedShipment(let iD, let UID, let weight, let weightUnit, let size, let sizeUnit, let description, let price, let priceUnit):
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
