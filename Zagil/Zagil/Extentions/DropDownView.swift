//
//  DropDownView.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 01/05/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import DropDown

extension DropDown {
    
    func setAppearance() {
        textColor = .black
        selectedTextColor = .white
        textFont = .regular(fontSize: 15, font: .segoe)
        backgroundColor = .white
        selectionBackgroundColor = R.color.lightGreen()!
        cellHeight = 50
        dismissMode = .automatic
        setupCornerRadius(20.0)
    }
    
}
