//
//  ValidationDelegate.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

protocol ValidationDelegate: class {
    
    func onReturn(_ textField: ValidatorTextField)
    func onFocusLost(_ textField: ValidatorTextField, hasError: Bool)
    func didBeginEditing(_ textField: ValidatorTextField)
    func onValidationChanged(_ isValid: Bool)
}

extension ValidationDelegate {
    
    func onReturn(_ textField: ValidatorTextField) {}
    func onFocusLost(_ textField: ValidatorTextField, hasError: Bool) {}
    func didBeginEditing(_ textField: ValidatorTextField) {}
}
