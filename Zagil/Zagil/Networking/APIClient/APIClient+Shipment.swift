//
//  APIClient+Shipment.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import PromiseKit

extension APIClient {
    
    // MARK: - Class Methods
    
    class func getShipments(date: String) -> Promise<[SenderFeed]> {
        let iD = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let getShipments = ShipmentService.getShipments(iD: iD, date: date)
        return Promise<[SenderFeed]> { seal in
            firstly {
                NetworkManager.manager.request(getShipments)
            }.then { json -> Promise<[SenderFeed]> in
                guard let array = json as? [JSON] else { throw ServiceError.badResponse }
                return try decode(response: array)
            }.done { model in
                seal.fulfill(model)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func addShipment(name: String, phone: String, type: String, from: String, to: String, date: String, weight: String, weightUnit: String, size: String, sizeUnit: String, description: String, price: String, priceUnit: String) -> Promise<Empty> {
        let iD = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let addShipment = ShipmentService.addShipment(iD: iD,
                                                  type: type,
                                                  recieverName: name,
                                                  recieverPhone: phone,
                                                  from: from,
                                                  to: to,
                                                  date: date,
                                                  weight: weight,
                                                  weightUnit: weightUnit,
                                                  size: size,
                                                  sizeUnit: sizeUnit,
                                                  description: description,
                                                  price: price,
                                                  priceUnit: priceUnit)
        return Promise<Empty> { seal in
            firstly {
                NetworkManager.manager.request(addShipment)
            }.then { json -> Promise<Empty> in
                guard let array = json as? [JSON] else { throw ServiceError.badResponse }
                return try decode(response: array)
            }.done { model in
                seal.fulfill(model)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func getPostedShipments(status: String) -> Promise<[PostedShipment]> {
        let iD = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let getPostedShipments = ShipmentService.getPostedShipments(iD: iD, status: status)
        return Promise<[PostedShipment]> { seal in
            firstly {
                NetworkManager.manager.request(getPostedShipments)
            }.then { json -> Promise<[PostedShipment]> in
                guard let array = json as? [JSON] else { throw ServiceError.badResponse }
                return try decode(response: array)
            }.done { model in
                seal.fulfill(model)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func deletePostedShipment(iD: String) -> Promise<Bool> {
        let UID = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let deletePostedShipment = ShipmentService.deletePostedShipment(iD: iD, UID: UID)
        return Promise<Bool> { seal in
            firstly {
                NetworkManager.manager.request(deletePostedShipment)
            }.then { json -> Promise<DeletePostedShipmentResponse> in
                guard let array = json as? [JSON], !array.isEmpty else { throw ServiceError.badResponse }
                guard let result = array.first as? [String : JSON] else { throw ServiceError.badResponse }
                return try decode(response: result)
            }.done { model in
                seal.fulfill(model.isDeleted)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func updatePostedShipment(iD: String, weight: String, weightUnit: String, size: String, sizeUnit: String, description: String, price: String, priceUnit: String) -> Promise<Bool> {
        let UID = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let updatePostedShipment = ShipmentService.updatePostedShipment(iD: iD,
                                                                        UID: UID,
                                                                        weight: weight,
                                                                        weightUnit: weightUnit,
                                                                        size: size,
                                                                        sizeUnit: sizeUnit,
                                                                        description: description,
                                                                        price: price,
                                                                        priceUnit: priceUnit)
        return Promise<Bool> { seal in
            firstly {
                NetworkManager.manager.request(updatePostedShipment)
            }.then { json -> Promise<UpdatePostedShipmentResponse> in
                guard let array = json as? [JSON] else { throw ServiceError.badResponse }
                return try decode(response: array)
            }.done { model in
                seal.fulfill(model.isUpdated)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
}
