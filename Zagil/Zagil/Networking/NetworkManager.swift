//
//  NetworkManager.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 22/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Moya
import PromiseKit
import Reachability

typealias JSON = Any

class NetworkManager: NSObject {
    
    
    // MARK: - Class Properties
    
    public static var manager: NetworkManager = NetworkManager()
    private var session: Session
    private var reachability: Reachability
    private var isConnected: Bool
    
    
    // MARK: - Initialization Methods
    
    private override init() {
        let authHandler = AuthHandler(token: "", authorization: .bearer)
        session = Session(interceptor: authHandler)
        
        reachability = try! Reachability()
        isConnected = true
        super.init()
        
        reachability.whenReachable = { [weak self] _ in
            guard let self = self else { return }
            self.isConnected = true
        }
        reachability.whenUnreachable = { [weak self] _ in
            guard let self = self else { return }
            self.isConnected = false
        }
        
        do {
            try reachability.startNotifier()
        } catch(let error) {
            Logger.shared.log(message: "Reachability Error: \(error.localizedDescription)", type: .debug)
        }
    }
    
    deinit {
        reachability.stopNotifier()
    }
    
    
    // MARK: - Class Methods
    
    public func request<T: ServiceType>(_ target: T) -> Promise<JSON> {
        let provider = MoyaProvider<T>(callbackQueue: .main, session: session)
        return Promise<JSON> { seal in
            if isConnected {
                provider.request(target) { result in
                    Logger.shared.log(message: "=====Response=====", type: .debug)
                    switch result {
                    case .success(let response):
                        Logger.shared.log(message: "EndPoint: \(String(describing: response.request?.url?.absoluteString))", type: .debug)
                        do {
                            let json = try response.mapJSON()
                            Logger.shared.log(message: "Response: \(json)", type: .debug)
                            seal.fulfill(json)
                        } catch(let error) {
                            // Parsing Error
                            let err = ServiceError.jsonMapping(error)
                            Logger.shared.log(message: err.errorDescription ?? error.localizedDescription, type: .debug)
                            seal.reject(err)
                        }
                    case .failure(let error):
                        // Request Error
                        switch error.errorCode {
                        case 400:
                            let err = ServiceError.badRequest(error)
                            Logger.shared.log(message: err.errorDescription ?? error.localizedDescription, type: .debug)
                            seal.reject(err)
                        case 401:
                            let err = ServiceError.authorization
                            Logger.shared.log(message: err.errorDescription ?? error.localizedDescription, type: .debug)
                            seal.reject(err)
                        case 408:
                            let err = ServiceError.timeout
                            Logger.shared.log(message: err.errorDescription ?? error.localizedDescription, type: .debug)
                            seal.reject(err)
                        default:
                            let err = ServiceError.server(code: error.errorCode)
                            Logger.shared.log(message: err.errorDescription ?? error.localizedDescription, type: .debug)
                            seal.reject(err)
                        }
                        
                    }
                    
                    Logger.shared.log(message: "=====End=====", type: .debug)
                }
            } else {
                let err = ServiceError.internet
                seal.reject(err)
            }
        }
    }
    
    public var isNetworkConnected: Bool {
        return isConnected
    }
    
}
