//
//  Logout.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 27/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

public class Logout {
    
    // MARK: - Class Properties
    
    public static let me = Logout()
    private var viewController: UIViewController!
    private var provider: Provider!
    
    
    // MARK: - Public Methods
    
    public func on(provider type: ProviderType, from vc: UIViewController, _ completion: @escaping Providing.ProvidingCompletion) {
        viewController = vc
        switch type {
        case .google: logoutOnGoogle(completion: completion)
        case .facebook: logoutOnFacebook(completion: completion)
        case .apple: logoutOnApple(completion: completion)
        }
    }
    
    
    // MARK: - Private Methods
    
    private func logoutOnGoogle(completion: @escaping Providing.ProvidingCompletion) {
        guard let provider = GoogleProvider(viewController: viewController) else {
            completion(.failure(.provider))
            return
        }
        self.provider = provider
        self.provider.authorize(completion)
    }
    
    private func logoutOnFacebook(completion: @escaping Providing.ProvidingCompletion) {
        guard let provider = FacebookProvider(viewController: viewController) else {
            completion(.failure(.provider))
            return
        }
        self.provider = provider
        self.provider.authorize(completion)
    }
    
    private func logoutOnApple(completion: @escaping Providing.ProvidingCompletion) {
        guard let provider = AppleProvider(viewController: viewController) else {
            completion(.failure(.provider))
            return
        }
        self.provider = provider
        self.provider.authorize(completion)
    }
}
