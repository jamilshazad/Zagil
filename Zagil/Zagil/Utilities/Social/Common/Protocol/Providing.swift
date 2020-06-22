//
//  Providing.swift
//  SocialNetwork
//
//  Created by Muhammad Khaliq ur Rehman on 26/02/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

public protocol Providing {
    typealias ProvidingCompletion = (Result<SocialSession, AuthorizeError>) -> Void
    var name: String { get }
    var viewController: UIViewController! { get }
    init?(viewController: UIViewController)
    func authorize(_ completion: @escaping Providing.ProvidingCompletion)
    func logout()
}
