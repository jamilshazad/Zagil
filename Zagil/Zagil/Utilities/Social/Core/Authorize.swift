//
//  Authorize.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 26/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

public class Authorize {
    
    // MARK: - Class Properties
    
    public static let me = Authorize()
    private var viewController: UIViewController!
    private var provider: Provider!
    
    
    // MARK: - Public Methods
    
    public func on(provider type: ProviderType, from vc: UIViewController, _ completion: @escaping Providing.ProvidingCompletion) {
        viewController = vc
        switch type {
        case .google: authorizeOnGoogle(completion: completion)
        case .facebook: authorizeOnFacebook(completion: completion)
        case .apple: authorizeOnApple(completion: completion)
        }
    }
    
    
    // MARK: - Private Methods
    
    private func authorizeOnGoogle(completion: @escaping Providing.ProvidingCompletion) {
        guard let provider = GoogleProvider(viewController: viewController) else {
            completion(.failure(.provider))
            return
        }
        self.provider = provider
        self.provider.authorize(completion)
    }
    
    private func authorizeOnFacebook(completion: @escaping Providing.ProvidingCompletion) {
        guard let provider = FacebookProvider(viewController: viewController) else {
            completion(.failure(.provider))
            return
        }
        self.provider = provider
        self.provider.authorize(completion)
    }
    
    private func authorizeOnApple(completion: @escaping Providing.ProvidingCompletion) {
        guard let provider = AppleProvider(viewController: viewController) else {
            completion(.failure(.provider))
            return
        }
        self.provider = provider
        self.provider.authorize(completion)
    }
}
