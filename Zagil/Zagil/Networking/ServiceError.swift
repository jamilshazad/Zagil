//
//  ServiceError.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 22/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

public enum ServiceError: Swift.Error {
    case internet
    case badRequest(Swift.Error)
    case authorization
    case timeout
    case server(code: Int)
    case jsonMapping(Swift.Error)
    case codableMapping(Swift.Error)
    case badResponse
    case userExists
    case userNotExists
}


// MARK: - Error Descriptions

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .internet:
            return R.string.localizable.internetErrorMessage()
        case .badRequest(let error):
            return error.localizedDescription
        case .authorization:
            return R.string.localizable.authorizationErrorMessage()
        case .timeout:
            return R.string.localizable.timeoutErrorMessage()
        case .server:
            return R.string.localizable.serverErrorMessage()
        case .jsonMapping(let error):
            return "\(R.string.localizable.jsonMappingErrorMessage()) \(error.localizedDescription)."
        case .codableMapping(let error):
            return error.localizedDescription
        case .badResponse:
            return R.string.localizable.badResponseErrorMessage()
        case .userExists:
            return R.string.localizable.userExistsErrorMessage()
        case .userNotExists:
            return R.string.localizable.userNotExistsErrorMessage()
        }
    }
    
    public var errorTitle: String? {
        switch self {
        case .internet: return R.string.localizable.internetErrorTitle()
        case .badRequest: return R.string.localizable.badRequestErrorTitle()
        case .authorization: return R.string.localizable.authorizationErrorTitle()
        case .timeout: return R.string.localizable.timeoutErrorTitle()
        case .server: return R.string.localizable.serverErrorTitle()
        case .jsonMapping: return R.string.localizable.jsonMappingErrorTitle()
        case .codableMapping: return R.string.localizable.codableMappingErrorTitle()
        case .badResponse: return R.string.localizable.badRequestErrorTitle()
        case .userExists: return R.string.localizable.userExistsErrorTitle()
        case .userNotExists: return "\(R.string.localizable.userNotExistsErrorMessage())"
        }
    }
}
