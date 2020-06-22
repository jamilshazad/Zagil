//
//  FacebookProvider.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 26/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import FBSDKLoginKit

open class FacebookProvider: Provider {
    
    
    // MARK: - Class Properties
    
    public override var name: String { return "FacebookProvider" }
    private var loginManager: LoginManager!
    
    
    // MARK: - Initialization Methods
    
    public required init?(viewController: UIViewController) {
        super.init(viewController: viewController)
        loginManager = LoginManager()
    }
    
    
    // MARK: - Public Methods
    
    public override func authorize(_ completion: @escaping Providing.ProvidingCompletion) {
        performLogin(completion: completion)
    }
    
    public override func logout() {
        loginManager.logOut()
    }
    
    
    // MARK: - Private Methods
    
    private func performLogin(completion: @escaping Providing.ProvidingCompletion) {
        let permissions: [FacebookPermission] = [.profile, .email]
        let readPermissions = permissions.compactMap { $0.description }
        loginManager.logIn(permissions: readPermissions, from: viewController) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(.custom(error)))
            } else {
                guard let result = result else {
                    completion(.failure(.provider))
                    return
                }
                if result.isCancelled {
                    completion(.failure(.cancel))
                } else {
                    self.getUser(completion: completion)
                }
            }
        }
    }
    
    private func getUser(completion: @escaping Providing.ProvidingCompletion) {
        let readPermissions: [String] = FacebookPermission.allCases.compactMap {
            if $0 != .profile {
                return $0.description
            } else {
                return nil
            }
        }
        let paramsString = readPermissions.joined(separator: ",")
        let parameters = ["fields" : paramsString]
        let userRequest = GraphRequest(graphPath: "me", parameters: parameters)
        userRequest.start { [weak self] connection, result, error in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(.custom(error)))
            } else {
                if let info = result as? [String : Any] {
                    guard let userID = info[FacebookPermission.id.description] as? String else {
                        completion(.failure(.parse))
                        return
                    }
                    guard let name = info[FacebookPermission.firstName.description] as? String else {
                        completion(.failure(.parse))
                        return
                    }
                    
                    var user = SocialUser(id: userID, name: name, email: "", info: info)
                    
                    if let email = info[FacebookPermission.email.description] as? String {
                        user.email = email
                    }
                    
                    guard let token = AccessToken.current else {
                        completion(.failure(.parse))
                        return
                    }
                    let session = SocialSession(token: token.tokenString, user: user, additionalInfo: [:])
                    completion(.success(session))
                    
                    // Developer's Note: We don't want Google SDK to maintain session for app anymore
                    // e.g. User may want to use different Google email anytime
                    self.logout()
                    
                } else {
                    completion(.failure(.provider))
                }
            }
        }
    }
    
}
