//
//  Registerable.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

protocol Registerable {
    static var identifier: String { get }
    static func getNIB() -> UINib
}

extension Registerable {

    static var identifier: String {
        return String(describing: self)
    }
    
    static func getNIB() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
