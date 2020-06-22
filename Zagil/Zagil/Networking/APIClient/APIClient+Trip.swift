//
//  APIClient+Dashboard.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import PromiseKit

extension APIClient {
    
    // MARK: - Class Methods
    
    class func getTrips(date: String) -> Promise<[SenderFeed]> {
        let iD = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let getTrips = TripService.getTrips(iD: iD, date: date)
        return Promise<[SenderFeed]> { seal in
            firstly {
                NetworkManager.manager.request(getTrips)
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
    
    class func addTrip(from: String, to: String, date: String, weight: String, weightUnit: String, size: String, sizeUnit: String, description: String, price: String, priceUnit: String) -> Promise<Empty> {
        let iD = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let addTrip = TripService.addTrip(iD: iD,
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
                NetworkManager.manager.request(addTrip)
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
    
    class func getPostedTrips() -> Promise<[PostedTrip]> {
        let iD = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let getPostedTrips = TripService.getPostedTrips(iD: iD)
        return Promise<[PostedTrip]> { seal in
            firstly {
                NetworkManager.manager.request(getPostedTrips)
            }.then { json -> Promise<[PostedTrip]> in
                guard let array = json as? [JSON] else { throw ServiceError.badResponse }
                return try decode(response: array)
            }.done { model in
                seal.fulfill(model)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func deletePostedTrip(iD: String) -> Promise<Bool> {
        let UID = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let deletePostedTrip = TripService.deletePostedTrip(iD: iD, UID: UID)
        return Promise<Bool> { seal in
            firstly {
                NetworkManager.manager.request(deletePostedTrip)
            }.then { json -> Promise<DeletePostedTripResponse> in
                guard let array = json as? [JSON] else { throw ServiceError.badResponse }
                return try decode(response: array)
            }.done { model in
                seal.fulfill(model.isDeleted)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func updatePostedTrip(iD: String, weight: String, weightUnit: String, size: String, sizeUnit: String, description: String, price: String, priceUnit: String) -> Promise<Bool> {
        let UID = String(ZAUserDefaults.user.get()?.iD ?? -1)
        let updatePostedTrip = TripService.updatePostedTrip(iD: iD,
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
                NetworkManager.manager.request(updatePostedTrip)
            }.then { json -> Promise<UpdatePostedTripResponse> in
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
