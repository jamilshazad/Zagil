//
//  ZAAddTripViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import GooglePlaces
import DropDown
import UITextView_Placeholder
class ZAAddTripViewController: ZATableViewController {

    
    // MARK: - Class Properties
    
    private var isHiddenDatePicker: Bool = true
    private var isHiddenArrivalDatePicker: Bool = true
    var selectCurrency = ""

    @IBOutlet private var fromTextField: ZATextField!
    @IBOutlet private var toTextField: ZATextField!
    @IBOutlet private var selectDateButton: UIButton!
    @IBOutlet private var selectArrivalDateButton: UIButton!
    @IBOutlet private var weightTextField: ZATextField!
    @IBOutlet private var weightUnitTextField: ZATextField!
    @IBOutlet private var sizeTextField: ZATextField!
    @IBOutlet private var sizeUnitTextField: ZATextField!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var priceTextField: ZATextField!
    @IBOutlet private var priceUnitTextField: ZATextField!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var arrivalDatePicker: UIDatePicker!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var arrivalDateLabel: UILabel!

    private var postTripButton: ZAButton!
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
        navigationItem.title = "New Trip"
    }
    
    private func setupViewController() {
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 70, right: 0)
        let minDate = Date().addingTimeInterval(24 * 60 * 60)
        datePicker.setDate(minDate, animated: true)
        datePicker.minimumDate = minDate
        setupWeightUnitDropDown()
        setupSizeUnitDropDown()
        setupPriceUnitDropDown()
        descriptionTextView.placeholder = "Description";
    }
    
    private func addPostButton() {
        if let view = navigationController?.view {
            postTripButton = ZAButton(frame: CGRect(x: 0, y: 0, width: view.width, height: 48))
           // postTripButton.cornerRadius = 8
            postTripButton.setTitle("Post Trip", for: .normal)
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
        priceUnitDropDown.bottomOffset = CGPoint(x: 0, y: priceUnitTextField.height)
        priceUnitDropDown.anchorView = priceUnitTextField
        priceUnitDropDown.dataSource = Constants.currencyDataSource
        priceUnitDropDown.selectRow(0)
        priceUnitDropDown.selectionAction = { [weak self] _, item in
            guard let self = self else { return }
            self.priceUnitTextField.text = item.getCurrencyOfString()
            self.selectCurrency = item;
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
        guard let price = priceTextField.text, !price.isEmpty else {
            showAlert(message: "Price can't be empty.")
            return false
        }
        
        return true
    }

}


// MARK: - Action Methods

extension ZAAddTripViewController {
    
    @IBAction private func selectDateTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        datePickerChanged(datePicker)
        isHiddenDatePicker = !isHiddenDatePicker
        tableView.beginUpdates()
        if isHiddenDatePicker {
            tableView.deleteRows(at: [IndexPath(row: 3, section: 0)], with: .top)
        } else {
            tableView.insertRows(at: [IndexPath(row: 3, section: 0)], with: .top)
        }
        tableView.endUpdates()
    }
    
    @IBAction private func selectArrivalDateTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        dateArrivalPickerChanged(arrivalDatePicker)
        isHiddenArrivalDatePicker = !isHiddenArrivalDatePicker
        tableView.beginUpdates()
        if isHiddenArrivalDatePicker {
            tableView.deleteRows(at: [IndexPath(row: 1, section: 1)], with: .top)
        } else {
            tableView.insertRows(at: [IndexPath(row: 1, section: 1)], with: .top)
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
    
    @IBAction private func dateArrivalPickerChanged(_ sender: UIDatePicker) {
        arrivalDateLabel.text = sender.date.getString(of: .dd_MM_YYYY)
    }
    
    @objc
    private func postTripButtonTapped(_ sender: ZAButton) {
        let userIsLogin = self.checkIfUserIsLogin()
        if (!userIsLogin){
            return
        }
        if validateData() {
            showHud()
            APIClient.addTrip(from: fromTextField.text!,
                              to: toTextField.text!,
                              departureDate: dateLabel.text!,
                              arrivalDate: arrivalDateLabel.text!,
                              weight: weightTextField.text!,
                              weightUnit: weightUnitTextField.text!,
                              size: sizeTextField.text!,
                              sizeUnit: sizeUnitTextField.text!,
                              description: descriptionTextView.text!,
                              price:   priceTextField.text!,
                              priceUnit: self.selectCurrency).done { [weak self] _ in
                                guard let self = self else { return }
                                self.hideHud()
                                self.showAlert("Success", message: "Trip has been Posted!") { [weak self] in
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

extension ZAAddTripViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return isHiddenDatePicker ? 3 : 4
        } else if section == 1 {
            return isHiddenArrivalDatePicker ? 1 : 2
        }
        else {
            return 5
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

extension ZAAddTripViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if tableView.numberOfRows(inSection: 0) > 3 {
            isHiddenDatePicker = false
            selectDateTapped(selectDateButton)
        } else if tableView.numberOfRows(inSection: 1) > 1 {
            isHiddenArrivalDatePicker = false
            selectArrivalDateTapped(selectArrivalDateButton)
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
        case weightTextField: sizeTextField.becomeFirstResponder()
        case sizeTextField: descriptionTextView.becomeFirstResponder()
        default: break
        }
        
        return true
    }
    
}


// MARK: - Text View Methods

extension ZAAddTripViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if tableView.numberOfRows(inSection: 0) > 3 {
            isHiddenDatePicker = false
            selectDateTapped(selectDateButton)
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            priceTextField.becomeFirstResponder()
            return false
        }
        return true
    }
    
}


// MARK: - Google Places Methods

extension ZAAddTripViewController: GMSAutocompleteViewControllerDelegate {
    
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
