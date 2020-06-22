//
//  ZAMyShipmentsViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 01/05/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import MASegmentedControl

class ZAMyShipmentsViewController: ZAViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var segmentControl: MASegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    private var shipments: [PostedShipment] = []
    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        let titleView = ZATitleView()
        titleView.text = "My Shipments"
        titleView.image = UIImage(named: "bus")
        navigationItem.titleView = titleView
    }
    
    private func setupViewController() {
        setupSegmentControl()
        setupTableView()
        loadShipments()
    }
    
    private func setupSegmentControl() {
        segmentControl.itemsWithText = true
        segmentControl.fillEqually = true
        segmentControl.bottomLineThumbView = true
        segmentControl.setSegmentedWith(items: ["Posted Shipments", "On Route Shipments"])
        segmentControl.titlesFont = UIFont.bold(fontSize: 15, font: .segoe)
        segmentControl.textColor = .white
        segmentControl.selectedTextColor = .white
        segmentControl.thumbViewColor = .white
        segmentControl.segmentedBackGroundColor = R.color.lightGreen()!
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.register(types: ZAShipmentTableViewCell.self)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func updateTableView() {
        tableView.reloadData()
        if shipments.isEmpty {
            tableView.setEmptyBackgroundView(text: R.string.localizable.noResultMessage())
        } else {
            tableView.resetBackgroundView()
        }
    }
    
    private func loadShipments() {
        showHud()
        APIClient.getPostedShipments().done { [weak self] shipments in
            guard let self = self else { return }
            self.hideHud()
            self.shipments = shipments
            self.updateTableView()
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.hideHud()
            self.displayService(error: error)
        }
    }

}


// MARK: - Action Methods

extension ZAMyShipmentsViewController {
    
    @IBAction private func segmentTapped(_ sender: MASegmentedControl) {
        loadShipments()
    }
    
}


// MARK: - Table View Methods

extension ZAMyShipmentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shipments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: ZAShipmentTableViewCell.self) else { return UITableViewCell() }
        
        guard let shipment = shipments[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.configure(shipment: shipment)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        push(viewController: ZAPostedShipmentDetailViewController.self, storyboard: R.storyboard.shipments()) { [weak self] detailVC in
            guard let self = self,
                let shipment = self.shipments[safe: indexPath.row] else { return }
            detailVC.shipment = shipment
        }
    }
    
}
