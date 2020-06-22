//
//  Validator.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class Validator: NSObject {
    
    
    // MARK: - Class Properties
    
    private var view: UIView
    private var scrollView: UIScrollView? = nil
    private weak var delegate: ValidationDelegate? = nil
    private var objects: [ValidationObject] = []
    
    
    // MARK: - Initialization Methods
    
    init(with view: UIView, scrollView: UIScrollView? = nil, delegate: ValidationDelegate? = nil) {
        self.view = view
        self.scrollView = scrollView
        self.delegate = delegate
        super.init()
    }
    
    
    // MARK: - Public Methods
    
    public func configure(_ objects: ValidationObject...) {
        self.objects = objects
        self.objects.forEach { configure(textField: $0.textField) }
    }
    
    public func validate() {
        let valid = performValidation()
        delegate?.onValidationChanged(valid)
    }
}


// MARK: - Private Methods

extension Validator {
    
    private func configure(textField: UITextField) {
        textField.delegate = self
        textField.returnKeyType = (self.objects.last?.textField == textField) ? .done : .next
        textField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingBegin(_:)), for: .editingChanged)
    }
    
    private func performValidation() -> Bool {
        var isValid = true
        
        for object in objects {
            isValid = isValid && object.isValid()
        }
        
        return isValid
    }
}


// MARK: - Action Methods

extension Validator {
    
    @objc private func editingChanged(_ textField: UITextField) {
        if let index = objects.firstIndex(where: { $0.textField == textField }),
            objects[index].rules.contains(where: { $0.isPhoneNumber }) {
            textField.text = textField.text?.formatPhoneNumber()
        }
        validate()
    }
    
    @objc private func editingBegin(_ textField: UITextField) {
        if textField is ValidatorTextField {
            delegate?.didBeginEditing(textField as! ValidatorTextField)
        }
        scrollView?.scrollTo(textField)
        validate()
    }
}


// MARK: - TextField Methods

extension Validator: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let last = objects.last, last.textField == textField {
            view.endEditing(true)
        } else {
            if let index = objects.firstIndex(where: { $0.textField == textField }) {
                if objects[index].shouldReturn {
                    objects[index + 1].textField.becomeFirstResponder()
                } else {
                    if let text = objects[index + 1].textField.text, text.isEmpty {
                        objects[index + 1].textField.text = " "
                    }
                    delegate?.onReturn(objects[index].textField)
                }
            }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let index = objects.firstIndex(where: { $0.textField == textField }) {
            let object = objects[index]
            let length = (textField.text?.count ?? 0) + string.count - range.length
            let previousText = object.textField.text ?? ""
            
            if (textField.text?.isEmpty ?? true) && string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return false
            } else {
                return object.rules.shouldChange(characters: string, text: previousText, lenght: length)
            }
        }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let index = objects.firstIndex(where: { $0.textField == textField }) {
            let field = objects[index].textField
            delegate?.onFocusLost(field, hasError: field.hasError)
        }
        
        validate()
    }
}
