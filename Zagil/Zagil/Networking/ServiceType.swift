//
//  ServiceType.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Moya
import Alamofire

protocol ServiceType: TargetType, AccessTokenAuthorizable {}

extension ServiceType {
    
    // Base URL
    var baseURL: URL {
        return URL(string: ConfigurationManager.value(for: .baseUrl))!
    }
    
    // Request Headers
    var headers: [String : String]? {
        return nil
    }
    
    // Sample Data for Testing
    var sampleData: Data {
        return Data()
    }
    
    // Possible Valid HTTP Codes
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
}
