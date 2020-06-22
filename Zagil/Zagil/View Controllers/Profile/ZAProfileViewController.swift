//
//  ZAProfileViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 20/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import NextGrowingTextView

class ZAProfileViewController: ZAViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var editProfileImageView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var birthdayLabel: UILabel!
    @IBOutlet private weak var addressTextView: NextGrowingTextView!
    @IBOutlet private weak var addressTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var phoneTextField: ZATextField!
    @IBOutlet private weak var emailTextField: ZATextField!
    @IBOutlet private weak var saveChangesButton: ZAButton!
    private var validator: Validator!
    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.layer.zPosition = -1
    }
    
    private func setupViewController() {
        saveChangesButton.applyGradient(colours: [R.color.darkGreen()!, R.color.lightGreen()!])
        addressTextView.delegates.didChangeHeight = { [weak self] height in
            guard let self = self else { return }
            if height < 35 {
                self.addressTextViewHeightConstraint.constant = 35
            } else if height > 150 {
                self.addressTextViewHeightConstraint.constant = 150
            } else {
                self.addressTextViewHeightConstraint.constant = height
            }
        }
        if let user = ZAUserDefaults.user.get() {
            nameLabel.text = user.name
            birthdayLabel.text = user.birthday ?? "N/A"
            addressTextView.textView.text = user.address
            phoneTextField.text = user.phone
            emailTextField.text = user.email
        }
        setupViewWithoutEditing()
    }
    
    private func setupViewWithoutEditing() {
        editProfileImageView.isHidden = true
        addressTextView.cornerRadius = 0
        addressTextView.borderWidth = 0
        addressTextView.borderColor = UIColor.clear.withAlphaComponent(0.6)
        addressTextView.textView.keyboardDismissMode = .onDrag
        addressTextView.textView.returnKeyType = .next
        addressTextView.textView.enablesReturnKeyAutomatically = true
        addressTextView.textView.delegate = self
        addressTextView.textView.font = UIFont.regular(fontSize: 15, font: .segoe)
        addressTextView.textView.contentInset = UIEdgeInsets(top: 3, left: -5, bottom: 3, right: 3)
        addressTextView.isFlashScrollIndicatorsEnabled = false
        addressTextView.isUserInteractionEnabled = false
        
        phoneTextField.borderStyle = .none
        phoneTextField.isUserInteractionEnabled = false
        
        emailTextField.borderStyle = .none
        emailTextField.isUserInteractionEnabled = false
    }
    
    private func setupViewForEditing() {
        editProfileImageView.isHidden = false
        addressTextView.cornerRadius = 4
        addressTextView.borderWidth = 1
        addressTextView.borderColor = UIColor.lightGray.withAlphaComponent(0.6)
        addressTextView.textView.font = UIFont.regular(fontSize: 15, font: .segoe)
        addressTextView.textView.contentInset = UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 3)
        addressTextView.isFlashScrollIndicatorsEnabled = false
        addressTextView.isUserInteractionEnabled = true
        
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.isUserInteractionEnabled = true
        
        emailTextField.borderStyle = .roundedRect
        emailTextField.isUserInteractionEnabled = true
    }
    
    private func validateData() -> Bool {
        let phone = phoneTextField.text
        let email = emailTextField.text
        
        guard let user = ZAUserDefaults.user.get() else { return false }
        
        if user.phone != phone,
            let phone = phone,
            !phone.isEmpty,
            phone.count <= 13 {
            showAlert(message: "Invalid Phone Number.") { [weak self] in
                guard let self = self else { return }
                self.phoneTextField.becomeFirstResponder()
            }
            return false
        }
        
        if user.email != email,
            let email = email,
            !email.isEmpty,
            !ValidationRegex.email.validate(string: email) {
            showAlert(message: "Invalid Email Address.") { [weak self] in
                guard let self = self else { return }
                self.emailTextField.becomeFirstResponder()
            }
            return false
        }
        
        return true
    }
    
    private func saveChanges() {
        let image = profileImageView.image
        let address = addressTextView.textView.text
        let phone = phoneTextField.text
        let email = emailTextField.text
        
        Logger.shared.log(message: "Update New Data Here", type: .info)
    }

}


// MARK: - Action Methods

extension ZAProfileViewController {
    
    @IBAction private func saveChangesButtonTapped(_ sender: ZAButton) {
        view.endEditing(true)
        saveChangesButton.tag = saveChangesButton.tag == 0 ? 1 : 0
        if saveChangesButton.tag == 1 {
            saveChangesButton.setTitle("SAVE CHANGES", for: .normal)
            self.setupViewForEditing()
        } else if validateData() {
            saveChangesButton.setTitle("EDIT", for: .normal)
            self.setupViewWithoutEditing()
            saveChanges()
        }
    }
    
    @IBAction private func selectImageButtonTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.modalPresentationStyle = .fullScreen
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let actionCamera = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                guard let self = self else { return }
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            
            let actionPhotos = UIAlertAction(title: "Photos", style: .default) { [weak self] _ in
                guard let self = self else { return }
                imagePicker.sourceType = .savedPhotosAlbum
                self.present(imagePicker, animated: true, completion: nil)
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                alertController.addAction(actionCamera)
            }
            alertController.addAction(actionPhotos)
            alertController.addAction(actionCancel)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Logger.shared.log(message: "Image Source Type Not Available!", type: .warn)
        }
    }
    
}


// MARK: - Text View Methods

extension ZAProfileViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            phoneTextField.becomeFirstResponder()
            return false
        }
        return true
    }
    
}


// MARK: - Text Field Methods

extension ZAProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}


// MARK: - Image Picker Methods

extension ZAProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            profileImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
