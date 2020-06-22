//
//  Collection.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
