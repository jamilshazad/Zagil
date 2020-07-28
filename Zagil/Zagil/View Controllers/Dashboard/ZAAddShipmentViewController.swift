//
//  ZAAddShipmentViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import GooglePlaces
import DropDown
import UITextView_Placeholder
class ZAAddShipmentViewController: ZATableViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private var typeTextField: ZATextField!
    @IBOutlet private var weightTextField: ZATextField!
    @IBOutlet private var weightUnitTextField: ZATextField!
    @IBOutlet private var sizeTextField: ZATextField!
    @IBOutlet private var sizeUnitTextField: ZATextField!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var budgetTextField: ZATextField!
    @IBOutlet private var budgetUnitTextField: ZATextField!
    @IBOutlet private var nameTextField: ZATextField!
    @IBOutlet private var phoneNumberTextField: ZATextField!
    @IBOutlet private var fromTextField: ZATextField!
    @IBOutlet private var toTextField: ZATextField!
    @IBOutlet private var selectDateButton: UIButton!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var dateLabel: UILabel!
    private var postTripButton: ZAButton!
    private var isHiddenDatePicker: Bool = true
    private var selectedTextField: UITextField!
    private var weightUnitDropDown: DropDown!
    private var sizeUnitDropDown: DropDown!
    private var priceUnitDropDown: DropDown!
    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.addPostButton()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postTripButton.removeFromSuperview()
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "New Shipment"
    }
    
    private func setupViewController() {
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 70, right: 0)
        let minDate = Date().addingTimeInterval(24 * 60 * 60)
        datePicker.setDate(minDate, animated: true)
        datePicker.minimumDate = minDate
        setupWeightUnitDropDown()
        setupSizeUnitDropDown()
        setupPriceUnitDropDown()
        descriptionTextView.placeholder = "Description"
    }
    
    private func setupWeightUnitDropDown() {
        weightUnitDropDown = DropDown()
        weightUnitDropDown.setAppearance()
        weightUnitDropDown.bottomOffset = CGPoint(x: 0, y: weightUnitTextField.height)
        weightUnitDropDown.anchorView = weightUnitTextField
        weightUnitDropDown.dataSource = ["kg", "lbs"]
        weightUnitDropDown.selectRow(0)
        weightUnitDropDown.selectionAction = { [weak self] _, item in
            guard let self = self else { return }
            self.weightUnitTextField.text = item
        }
    }
    
    private func setupSizeUnitDropDown() {
        sizeUnitDropDown = DropDown()
        sizeUnitDropDown.setAppearance()
        sizeUnitDropDown.bottomOffset = CGPoint(x: 0, y: sizeUnitTextField.height)
        sizeUnitDropDown.anchorView = sizeUnitTextField
        sizeUnitDropDown.dataSource = ["cm", "m", "In"]
        sizeUnitDropDown.selectRow(0)
        sizeUnitDropDown.selectionAction = { [weak self] _, item in
            guard let self = self else { return }
            self.sizeUnitTextField.text = item
        }
    }
    
    private func setupPriceUnitDropDown() {
        priceUnitDropDown = DropDown()
        priceUnitDropDown.setAppearance()
        priceUnitDropDown.bottomOffset = CGPoint(x: 0, y: budgetUnitTextField.height)
        priceUnitDropDown.anchorView = budgetUnitTextField
        priceUnitDropDown.dataSource = Constants.currencyDataSource
        priceUnitDropDown.selectRow(0)
        priceUnitDropDown.selectionAction = { [weak self] _, item in
            guard let self = self else { return }
            self.budgetUnitTextField.text = item.getCurrencyOfString()
        }
    }
    
    private func addPostButton() {
        if let view = navigationController?.view {
            postTripButton = ZAButton(frame: CGRect(x: 0, y: 0, width: view.width, height: 48))
           // postTripButton.cornerRadius = 8
            postTripButton.setTitle("Post Shipment", for: .normal)
            postTripButton.setTitleColor(.white, for: .normal)
            postTripButton.applyGradient(colours: [R.color.lightGreen()!, R.color.darkGreen()!])
            postTripButton.addTarget(self, action: #selector(postTripButtonTapped(_:)), for: .touchUpInside)
            view.addSubview(postTripButton)
            postTripButton.constrainHeight(46)
            postTripButton.centerXToSuperview()
            postTripButton.anchor(.bottom(view.bottomAnchor, constant: view.safeAreaInsets.bottom + 20),
                                  .leading(view.leadingAnchor, constant: 0),
                                  .trailing(view.trailingAnchor, constant: 0))
            view.bringSubviewToFront(postTripButton)
        }
    }
    
    private func showPlacesController(for textField: UITextField) {
        selectedTextField = textField
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
          UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        let navController = ZANavigationController(rootViewController: autocompleteController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    private func validateData() -> Bool {
        guard let type = typeTextField.text, !type.isEmpty else {
            showAlert(message: "Specify Type.")
            return false
        }
        guard let weight = weightTextField.text, !weight.isEmpty else {
            showAlert(message: "Weight can't be empty.")
            return false
        }
        guard let size = sizeTextField.text, !size.isEmpty else {
            showAlert(message: "Size can't be empty.")
            return false
        }
        guard let description = descriptionTextView.text, !description.isEmpty else {
            showAlert(message: "Description can't be empty.")
            return false
        }
        guard let budget = budgetTextField.text, !budget.isEmpty else {
            showAlert(message: "Budget can't be empty.")
            return false
        }
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Name can't be empty.")
            return false
        }
        guard let phone = phoneNumberTextField.text, !phone.isEmpty else {
            showAlert(message: "Phone Number can't be empty.")
            return false
        }
        guard let from = fromTextField.text, !from.isEmpty else {
            showAlert(message: "From Location can't be empty.")
            return false
        }
        guard let to = toTextField.text, !to.isEmpty else {
            showAlert(message: "To Location can't be empty.")
            return false
        }
        guard let dateString = dateLabel.text, !dateString.isEmpty, (dateString.toDate(format: .dd_MM_YYYY) != nil) else {
            showAlert(message: "Date can't be empty.")
            return false
        }
        
        
        return true
    }

}


// MARK: - Action Methods

extension ZAAddShipmentViewController {
    
    @IBAction private func selectDateTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        datePickerChanged(datePicker)
        isHiddenDatePicker = !isHiddenDatePicker
        tableView.beginUpdates()
        if isHiddenDatePicker {
            tableView.deleteRows(at: [IndexPath(row: 4, section: 2)], with: .top)
        } else {
            tableView.insertRows(at: [IndexPath(row: 4, section: 2)], with: .top)
        }
        tableView.endUpdates()
    }
    
    @IBAction private func selectWeightUnitTapped(_ sender: UIButton) {
        weightUnitDropDown.show()
    }
    
    @IBAction private func selectSizeUnitTapped(_ sender: UIButton) {
        sizeUnitDropDown.show()
    }
    
    @IBAction private func selectPriceUnitTapped(_ sender: UIButton) {
        priceUnitDropDown.show()
    }
    
    @IBAction private func datePickerChanged(_ sender: UIDatePicker) {
        dateLabel.text = sender.date.getString(of: .dd_MM_YYYY)
    }
    
   
    
    @objc
    private func postTripButtonTapped(_ sender: ZAButton) {
        let userIsLogin = self.checkIfUserIsLogin()
        if (!userIsLogin){
            return
        }
        
        if validateData() {
            showHud()
            APIClient.addShipment(name: nameTextField.text!,
                                  phone: phoneNumberTextField.text!,
                                  type: typeTextField.text!,
                                  from: fromTextField.text!,
                                  to: toTextField.text!,
                                  date: dateLabel.text!,
                                  weight: weightTextField.text!,
                                  weightUnit: weightUnitTextField.text!,
                                  size: sizeTextField.text!,
                                  sizeUnit: sizeUnitTextField.text!,
                                  description: descriptionTextView.text!,
                                  price: budgetTextField.text!,
                                  priceUnit: budgetUnitTextField.text!).done { [weak self] _ in
                                    guard let self = self else { return }
                                    self.hideHud()
                                    self.showAlert("Success", message: "Shipment has been Posted!") { [weak self] in
                                        guard let self = self else { return }
                                        self.navigationController?.popViewController(animated: true)
                                    }
            }.catch { [weak self] error in
                guard let self = self else { return }
                self.hideHud()
                self.displayService(error: error)
            }
        }
    }
    
}


// MARK: - Table View Methods

extension ZAAddShipmentViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 6
        case 1: return 3
        case 2: return isHiddenDatePicker ? 4 : 5
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}


// MARK: - Text Field Methods

extension ZAAddShipmentViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if tableView.numberOfRows(inSection: 2) > 4 {
            isHiddenDatePicker = false
            selectDateTapped(selectDateButton)
        }
        if textField == fromTextField || textField == toTextField {
            showPlacesController(for: textField)
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
        case typeTextField: weightTextField.becomeFirstResponder()
        case weightTextField: sizeTextField.becomeFirstResponder()
        case sizeTextField: descriptionTextView.becomeFirstResponder()
        case budgetTextField: nameTextField.becomeFirstResponder()
        case nameTextField: phoneNumberTextField.becomeFirstResponder()
        default: break
        }
        
        return true
    }
    
}


// MARK: - Text View Methods

extension ZAAddShipmentViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if tableView.numberOfRows(inSection: 2) > 4 {
            isHiddenDatePicker = false
            selectDateTapped(selectDateButton)
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            budgetTextField.becomeFirstResponder()
            return false
        }
        return true
    }
    
}


// MARK: - Google Places Methods

extension ZAAddShipmentViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        selectedTextField.text = place.name
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }

}
