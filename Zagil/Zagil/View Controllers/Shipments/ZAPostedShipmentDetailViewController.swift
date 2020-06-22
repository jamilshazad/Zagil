//
//  ZAPostedShipmentDetailViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 06/05/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import DropDown

class ZAPostedShipmentDetailViewController: ZAViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private var fromLocationLabel: UILabel!
    @IBOutlet private var fromClockLabel: UILabel!
    @IBOutlet private var toLocationLabel: UILabel!
    @IBOutlet private var toClockLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var weightTextField: UITextField!
    @IBOutlet private var weightUnitLabel: UILabel!
    @IBOutlet private var sizeTextField: UITextField!
    @IBOutlet private var sizeUnitLabel: UILabel!
    @IBOutlet private var priceTextField: UITextField!
    @IBOutlet private var priceUnitLabel: UILabel!
    @IBOutlet private var saveChangesButton: ZAButton!
    @IBOutlet private var packageRecievedButton: ZAButton!
    @IBOutlet private var cancelTripButton: ZAButton!
    private var weightUnitDropDown: DropDown!
    private var sizeUnitDropDown: DropDown!
    private var priceUnitDropDown: DropDown!
    public var shipment: PostedShipment!
    
    
    // MARK: - Life - Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Shipment"
    }
    
    private func setupViewController() {
        saveChangesButton.applyGradient(colours: [R.color.lightGreen()!, R.color.darkGreen()!])
        
        // Setup Drop Downs
        setupWeightUnitDropDown()
        setupSizeUnitDropDown()
        setupPriceUnitDropDown()
        
        // Pre-Filled Data
        fromLocationLabel.text = shipment.source
        fromClockLabel.text = shipment.date.toDate(format: .dd_MM_YYYY)?.getString(of: .EEEE_MMM_d_yyyy) ?? ""
        toLocationLabel.text = shipment.destination
        toClockLabel.text = ""
        descriptionTextView.text = shipment.description
        weightTextField.text = shipment.weight
        weightUnitLabel.text = shipment.weightUnit
        sizeTextField.text = shipment.size
        sizeUnitLabel.text = shipment.sizeUnit
        priceTextField.text = shipment.price
        priceUnitLabel.text = shipment.priceUnit
    }
    
    private func setupWeightUnitDropDown() {
        weightUnitDropDown = DropDown()
        weightUnitDropDown.setAppearance()
        weightUnitDropDown.bottomOffset = CGPoint(x: 0, y: weightUnitLabel.height)
        weightUnitDropDown.anchorView = weightUnitLabel
        weightUnitDropDown.dataSource = ["kg", "lbs"]
        weightUnitDropDown.selectRow(0)
        weightUnitDropDown.selectionAction = { [weak self] _, item in
            guard let self = self else { return }
            self.weightUnitLabel.text = item
        }
    }
    
    private func setupSizeUnitDropDown() {
        sizeUnitDropDown = DropDown()
        sizeUnitDropDown.setAppearance()
        sizeUnitDropDown.bottomOffset = CGPoint(x: 0, y: sizeUnitLabel.height)
        sizeUnitDropDown.anchorView = sizeUnitLabel
        sizeUnitDropDown.dataSource = ["cm", "m", "In"]
        sizeUnitDropDown.selectRow(0)
        sizeUnitDropDown.selectionAction = { [weak self] _, item in
            guard let self = self else { return }
            self.sizeUnitLabel.text = item
        }
    }
    
    private func setupPriceUnitDropDown() {
        priceUnitDropDown = DropDown()
        priceUnitDropDown.setAppearance()
        priceUnitDropDown.bottomOffset = CGPoint(x: 0, y: priceUnitLabel.height)
        priceUnitDropDown.anchorView = priceUnitLabel
        priceUnitDropDown.dataSource = Constants.currencyDataSource
        priceUnitDropDown.selectRow(0)
        priceUnitDropDown.selectionAction = { [weak self] _, item in
            guard let self = self else { return }
            self.priceUnitLabel.text = item
        }
    }
    
}


// MARK: - Action Methods

extension ZAPostedShipmentDetailViewController {
    
    @IBAction private func saveChangesButtonTapped(_ sender: ZAButton) {
        showHud()
        APIClient.updatePostedShipment(iD: "\(shipment.iD)",
            weight: weightTextField.text!,
            weightUnit: weightUnitLabel.text!,
            size: sizeTextField.text!,
            sizeUnit: sizeUnitLabel.text!,
            description: descriptionTextView.text!,
            price: priceTextField.text!,
            priceUnit: priceUnitLabel.text!).done { [weak self] _ in
                guard let self = self else { return }
                self.hideHud()
                self.showAlert("Success", message: "Shipment Updated!") { [weak self] in
                    guard let self = self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.hideHud()
            self.displayService(error: error)
        }
    }
    
    @IBAction private func packageRecievedButtonTapped(_sender: ZAButton) {
        
    }
    
    @IBAction private func cancelShipmentButtonTapped(_ sender: ZAButton) {
        showHud()
        APIClient.deletePostedShipment(iD: "\(shipment.iD)").done { [weak self] isDeleted in
            guard let self = self else { return }
            self.hideHud()
            self.showAlert("Shipment", message: "Shipment Deleted!") { [weak self] in
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
