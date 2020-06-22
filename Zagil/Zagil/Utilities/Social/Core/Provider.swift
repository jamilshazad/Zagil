//
//  Provider.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 26/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

open class Provider: NSObject, Providing {
    
    
    // MARK: - Class Properties
    
    public var name: String { return "Provider" }
    public var viewController: UIViewController!
    
    
    // MARK: - Initialization Methods
    
    public required init?(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        guard let _ = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            assertionFailure("Error Finding Info.plist file. Make sure file exists.")
            return nil
        }
    }
    
    
    // MARK: - Public Methods
    
    public func authorize(_ completion: @escaping (Result<SocialSession, AuthorizeError>) -> Void) {
        assertionFailure("Authorize Methods not implemented in Provider!")
    }
    
    public func logout() {
        assertionFailure("Logout Methods not implemented in Provider!")
    }
    
}
