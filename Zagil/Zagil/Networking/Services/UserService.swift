//
//  UserService.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 22/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Moya

enum UserService: ServiceType {
    
    // MARK: - Services
    
    case login(email: String, password: String)
    case signup(name: String, email: String, password: String)
    case verifyEmail(email: String)
    case updateFacebook(iD: String, email: String)
    case updateGoogle(iD: String, email: String)
    case loginWithSocial(iD: String, name: String, email: String, provider: String)
    case getIDByFacebookID(id: String)
    case getIDByGoogleID(id: String)

    
    // MARK: - Configuration
    
    var path: String {
        switch self {
        case .login: return "user/login"
        case .signup: return "user/signup"
        case .verifyEmail: return "user/emailCheck"
        case .updateFacebook: return "user/updateIDFacebook"
        case .updateGoogle: return "user/updateIDGoogle"
        case .loginWithSocial: return "user/loginWithGoogle"
        case .getIDByFacebookID: return "user/facebook/getID"
        case .getIDByGoogleID: return "user/google/getID"

        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .verifyEmail, .getIDByFacebookID, .getIDByGoogleID: return .get
        case .signup, .updateFacebook, .updateGoogle, .loginWithSocial: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            let params = ["email" : email,
                          "password" : password]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .signup(let name, let email, let password):
            let params = ["name": name,
                          "email" : email,
                          "password" : password]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .verifyEmail(let email):
            let params = ["email" : email]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .updateFacebook(let iD, let email):
            let params = ["id" : iD, "email" : email]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .updateGoogle(let iD, let email):
            let params = ["id" : iD, "email" : email]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .loginWithSocial(let iD, let name, let email, let provider):
            let params = ["id" : iD,
                          "name" : name,
                          "email" : email,
                          "requestFrom" : provider]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getIDByFacebookID(let facebookId):
            let params = ["f_id" : facebookId]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getIDByGoogleID(let googleId):
            let params = ["g_id" : googleId]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var authorizationType: AuthorizationType? { return nil }
    
}
