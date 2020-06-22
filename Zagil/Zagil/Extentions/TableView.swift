//
//  TableView.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(types: Registerable.Type ...) {
        for type in types {
            print("type: \(type), identifier: \(type.identifier)")
            register(type.getNIB(), forCellReuseIdentifier: type.identifier)
        }
    }
    
    func getCell<T: Registerable>(type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func setEmptyBackgroundView(text: String) {
        let emptyLabel = UILabel(frame: frame)
        emptyLabel.text = text
        emptyLabel.textAlignment = .center
        emptyLabel.font = UIFont.regular(fontSize: 20, font: .segoe)
        emptyLabel.textColor = .darkGray
        emptyLabel.numberOfLines = 0
        emptyLabel.sizeToFit()
        emptyLabel.isEnabled = false
        backgroundView = emptyLabel
    }
    
    func resetBackgroundView() {
        backgroundView = UIView(frame: .zero)
    }
    
}
