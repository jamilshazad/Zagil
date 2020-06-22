//
//  AppleProvider.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 27/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import AuthenticationServices

open class AppleProvider: Provider {
    
    
    // MARK: - Class Properties
    
    public override var name: String { return "AppleProvider" }
    private var loginCompletion: Providing.ProvidingCompletion!
    
    
    // MARK: - Initialization Methods
    
    public required init?(viewController: UIViewController) {
        super.init(viewController: viewController)
    }
    
    
    // MARK: - Public Methods
    
    public override func authorize(_ completion: @escaping Providing.ProvidingCompletion) {
        loginCompletion = completion
        if #available(iOS 13, *) {
            performLogin(completion: completion)
        }
    }
    
    public override func logout() {
        debugPrint("Logout from Apple Account")
    }
    
    
    // MARK: - Private Methods
    
    @available(iOS 13, *)
    private func performLogin(completion: @escaping Providing.ProvidingCompletion) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.delegate = self
        authController.performRequests()
    }
    
}


// MARK: - ASAuthorizationControllerPresentationContextProviding Methods

@available(iOS 13, *)
extension AppleProvider: ASAuthorizationControllerPresentationContextProviding {
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return viewController.view.window!
    }
}


// MARK: - ASAuthorizationControllerDelegates Methods

@available(iOS 13, *)
extension AppleProvider: ASAuthorizationControllerDelegate {
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        loginCompletion(.failure(.custom(error)))
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        let userID = appleIDCredential.user
        let name = appleIDCredential.fullName?.givenName ?? ""
        let email = appleIDCredential.email ?? ""
        let user = SocialUser(id: userID, name: name, email: email, info: [:])
        var identityToken = ""
        if let token = appleIDCredential.identityToken {
            identityToken = String(bytes: token, encoding: .utf8) ?? ""
        }
        let session = SocialSession(token: identityToken, user: user, additionalInfo: [:])
        loginCompletion(.success(session))
    }
}
