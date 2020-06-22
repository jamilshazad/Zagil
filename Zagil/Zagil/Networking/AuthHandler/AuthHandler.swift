//
//  AuthHandler.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 22/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Alamofire
import Moya

class AuthHandler: RequestInterceptor {
    
    // MARK: - Class Properties
    
    private var accessToken: String
    private var authorizationType: AuthorizationType
    private let lock = NSLock()
    private var requestsToRetry: [(RetryResult) -> Void] = []
    private var isRefreshing: Bool = false
    
    
    // MARK: - Initialization Methods
    
    init(token: String, authorization type: AuthorizationType) {
        accessToken = token
        authorizationType = type
    }
    
}


// MARK: - Request Adapter

extension AuthHandler {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url != nil else {
            completion(.failure(ServiceError.authorization))
            return
        }
        var request = urlRequest
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
    
}

// MARK: - Request Retrier

extension AuthHandler {
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock()
        defer { lock.unlock() }
        
        guard let task = request.task,
            let response = task.response as? HTTPURLResponse,
            response.statusCode == 401 else {
                return completion(.doNotRetry)
        }
        
        requestsToRetry.append(completion)
        
        if !isRefreshing {
            // Refresh Token Here Then Set it Then
            accessToken = "NEW_ACCESS_TOKEN"
            lock.lock()
            defer { lock.unlock() }
            requestsToRetry.forEach { $0(.retry) }
            requestsToRetry.removeAll()
        }
    }

}
