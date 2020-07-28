//
//  ZAMyTripsViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 01/05/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import MASegmentedControl

class ZAMyTripsViewController: ZAViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var segmentControl: MASegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    private var trips: [PostedTrip] = []
    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadTrips(status: "posted")
    }

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        let titleView = ZATitleView()
        titleView.text = "My Trips"
        titleView.image = UIImage(named: "airplane")
        navigationItem.titleView = titleView
    }
    
    private func setupViewController() {
        setupSegmentControl()
        setupTableView()
        loadTrips(status: "posted")
    }
    
    private func setupSegmentControl() {
        segmentControl.itemsWithText = true
        segmentControl.fillEqually = true
        segmentControl.bottomLineThumbView = true
        segmentControl.setSegmentedWith(items: ["Posted Trips", "On Route Trips"])
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
        if trips.isEmpty {
            tableView.setEmptyBackgroundView(text: R.string.localizable.noResultMessage())
        } else {
            tableView.resetBackgroundView()
        }
    }
    
    private func loadTrips(status: String) {
        showHud()
        APIClient.getPostedTrips(status: status).done { [weak self] trips in
            guard let self = self else { return }
            self.hideHud()
            self.trips = trips
            self.updateTableView()
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.hideHud()
            self.displayService(error: error)
        }
    }

}


// MARK: - Action Methods

extension ZAMyTripsViewController {
    
    @IBAction private func segmentTapped(_ sender: MASegmentedControl) {
        loadTrips(status: sender.selectedSegmentIndex == 0 ? "posted":"onroute")
    }
    
}


// MARK: - Table View Methods

extension ZAMyTripsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: ZAShipmentTableViewCell.self) else { return UITableViewCell() }
        
        guard let trip = trips[safe: indexPath.row] else { return UITableViewCell() }
        cell.configure(trip: trip)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        push(viewController: ZAPostedTripDetailViewController.self, storyboard: R.storyboard.shipments()) { [weak self] detailVC in
            guard let self = self,
                let trip = self.trips[safe: indexPath.row] else { return }
            detailVC.trip = trip
        }
    }
    
}
