//
//  SFSafariViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 19/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import SafariServices

extension SFSafariViewController {
    
    open override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            return .fullScreen
        }
        set {
            super.modalPresentationStyle = newValue
        }
    }
    
}
