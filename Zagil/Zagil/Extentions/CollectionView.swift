//
//  CollectionView.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func getCell<T: Registerable>(type: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func register(types: Registerable.Type ...) {
        for type in types {
            print("type: \(type), identifier: \(type.identifier)")
            register(type.getNIB(), forCellWithReuseIdentifier: type.identifier)
        }
    }
    
}
