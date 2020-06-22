//
//  APIClient+Authentication.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import PromiseKit

extension APIClient {
    
    // MARK: - Class Methods
    
    class func login(email: String, password: String) -> Promise<User> {
        let login = UserService.login(email: email, password: password)
        return Promise<User> { seal in
            firstly {
                NetworkManager.manager.request(login)
            }.then { json -> Promise<User> in
                guard let array = json as? [JSON], !array.isEmpty else { throw ServiceError.userNotExists }
                guard let result = array.first as? [String : JSON] else { throw ServiceError.badResponse }
                return try decode(response: result)
            }.done { model in
                seal.fulfill(model)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func signup(name: String, email: String, password: String) -> Promise<Empty> {
        return Promise<Empty> { seal in
            firstly {
                verify(email: email)
            }.then { isExists -> Promise<JSON> in
                if isExists {
                    throw ServiceError.userExists
                } else {
                    let signup = UserService.signup(name: name, email: email, password: password)
                    return NetworkManager.manager.request(signup)
                }
            }.then { json -> Promise<Empty> in
                try decode(response: json)
            }.done { model in
                seal.fulfill(model)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func verify(email: String) -> Promise<Bool> {
        let verifyEmail = UserService.verifyEmail(email: email)
        return Promise<Bool> { seal in
            firstly {
                NetworkManager.manager.request(verifyEmail)
            }.then { json -> Promise<VerifyUserResponse> in
                guard let array = json as? [JSON] else { throw ServiceError.badResponse }
                guard let result = array.first as? [String : JSON] else { throw ServiceError.badResponse }
                return try decode(response: result)
            }.done { model in
                seal.fulfill(model.isExist)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func updateSocial(iD: String, name: String, email: String, provider: ProviderType) -> Promise<User> {
        let updateSocialID = provider == .facebook ? UserService.updateFacebook(iD: iD, email: email) : UserService.updateGoogle(iD: iD, email: email)
        return Promise<User> { seal in
            firstly {
                NetworkManager.manager.request(updateSocialID)
            }.then { json -> Promise<UpdateSocialUserResponse> in
                guard let array = json as? [JSON], !array.isEmpty else { throw ServiceError.badResponse }
                guard let result = array.first as? [String : JSON] else { throw ServiceError.badResponse }
                return try decode(response: result)
           
            }.done { model in
            var user = User()
            //user.iD =
            user.name = name
            user.email = email
            if provider == .facebook {
                user.facebookID = iD
            } else {
                user.googleID = iD
            }
                seal.fulfill(user)
                
            }
//            .then { response -> Promise<User> in
//                if response.isUpdated {
//                    return socialLogin(iD: iD, name: name, email: email, provider: provider)
//                } else {
//                    throw ServiceError.badResponse
//                }
//            }
//             .done { model in
//               seal.fulfill(model)
//            }
            .catch { error in
                seal.reject(error)
            }
        }
    }
    
    class func socialLogin(iD: String, name: String, email: String, provider: ProviderType) -> Promise<User> {
        let socialPlatform = provider == .facebook ? "facebook" : "google"
        let updateSocialID = UserService.loginWithSocial(iD: iD, name: name, email: email, provider: socialPlatform)
        return Promise<User> { seal in
            firstly {
                NetworkManager.manager.request(updateSocialID)
            }.then { json -> Promise<LoginSocialUserResponse> in
                guard let array = json as? [JSON], !array.isEmpty else { throw ServiceError.userNotExists }
                guard let result = array.first as? [String : JSON] else { throw ServiceError.badResponse }
                return try decode(response: result)
            }.done { model in
                var user = User()
                user.iD = model.iD
                user.name = name
                user.email = email
                if provider == .facebook {
                    user.facebookID = iD
                } else {
                    user.googleID = iD
                }
                seal.fulfill(user)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
