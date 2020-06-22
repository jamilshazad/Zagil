//
//  GoogleProvider.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 27/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import GoogleSignIn

open class GoogleProvider: Provider {
    
    
    // MARK: - Class Properties
    
    public override var name: String { return "GoogleProvider" }
    private var loginManager: GIDSignIn!
    private var loginCompletion: Providing.ProvidingCompletion!
    
    
    // MARK: - Initialization Methods
    
    public required init?(viewController: UIViewController) {
        super.init(viewController: viewController)
        loginManager = GIDSignIn.sharedInstance()
    }
    
    
    // MARK: - Public Methods
    
    public override func authorize(_ completion: @escaping Providing.ProvidingCompletion) {
        loginCompletion = completion
        performLogin(completion: completion)
    }
    
    public override func logout() {
        loginManager.signOut()
    }
    
    
    // MARK: - Private Methods
    
    private func performLogin(completion: @escaping Providing.ProvidingCompletion) {
        loginManager.delegate = self
        loginManager.presentingViewController = viewController
        loginManager.signIn()
    }
    
}


// MARK: - GIDSignInDelegate Methods

extension GoogleProvider: GIDSignInDelegate {
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            let socialUser = SocialUser(id: user.userID, name: user.profile.name, email: user.profile.email, info: [:])
            let session = SocialSession(token: user.authentication.accessToken, user: socialUser, additionalInfo: [:])
            loginCompletion(.success(session))
            
            // Developer's Note: We don't want Google SDK to maintain session for app anymore
            // e.g. User may want to use different Google email anytime
            self.logout()
            
        } else {
            loginCompletion(.failure(.custom(error)))
        }
    }
    
}

