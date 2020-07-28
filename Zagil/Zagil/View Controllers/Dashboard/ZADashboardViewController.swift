//
//  ZADashboardViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 20/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

enum DashboardType {
    case sender
    case traveler
    case none
}

class ZADashboardViewController: ZAViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var senderButton: UIButton!
    @IBOutlet private weak var travelerButton: UIButton!
    @IBOutlet private weak var goButton: UIButton!
    private var type: DashboardType = .none
    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Dashboard"
    }
    
    private func setupViewController() {
        updateUi()
    }
    
    private func updateUi() {
        switch type {
        case .sender:
            senderButton.setImage(R.image.sender_selected(), for: .normal)
            travelerButton.setImage(R.image.traveler_unselected(), for: .normal)
            goButton.isEnabled = true
        case .traveler:
            senderButton.setImage(R.image.sender_unselected(), for: .normal)
            travelerButton.setImage(R.image.traveler_selected(), for: .normal)
            goButton.isEnabled = true
        case .none:
            senderButton.setImage(R.image.sender_unselected(), for: .normal)
            travelerButton.setImage(R.image.traveler_unselected(), for: .normal)
            goButton.isEnabled = false
        }
    }

}


// MARK: - Action Methods

extension ZADashboardViewController {
    
    @IBAction func senderButtonTapped(_ sender: UIButton) {
        type = .sender
        updateUi()
    }
    
    @IBAction func travelerButtonTapped(_ sender: UIButton) {
        type = .traveler
        updateUi()
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton) {
        switch type {
        case .sender:
            push(viewController: ZATravelerFeedViewController.self, storyboard: R.storyboard.dashboard())
        case .traveler:
            push(viewController: ZASenderFeedsViewController.self, storyboard: R.storyboard.dashboard())

        case .none:
            break
        }
    }
    
    
    @IBAction func receivedOffer() {
        push(viewController: ZAOfferListViewController.self, storyboard: R.storyboard.messages())

    }
    
}
