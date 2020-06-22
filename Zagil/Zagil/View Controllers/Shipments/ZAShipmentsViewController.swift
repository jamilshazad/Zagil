//
//  ZAShipmentsViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 20/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ZAShipmentsViewController: ZAViewController {
    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Shipments"
    }

}


// MARK: - Action Methods

extension ZAShipmentsViewController {
    
    @IBAction func shipmentsButtonTapped(_ sender: UIButton) {
        push(viewController: ZAMyShipmentsViewController.self, storyboard: R.storyboard.shipments())
    }
    
    @IBAction func tripsButtonTapped(_ sender: UIButton) {
        push(viewController: ZAMyTripsViewController.self, storyboard: R.storyboard.shipments())
    }
    
    @IBAction func activityButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        push(viewController: ZASettingsViewController.self, storyboard: R.storyboard.shipments())
    }
    
}
