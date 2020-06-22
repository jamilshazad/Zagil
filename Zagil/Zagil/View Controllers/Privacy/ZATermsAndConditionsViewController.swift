//
//  ZATermsAndConditionsViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 19/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ZATermsAndConditionsViewController: ZAViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var agreeButton: ZAButton!
    @IBOutlet private weak var declineButton: ZAButton!
    public var hideButtons: Bool = false
    
    
    // MARK: - Life - Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }

    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Terms & Conditions"
    }
    
    private func setupViewController() {
        agreeButton.isHidden = hideButtons
        declineButton.isHidden = hideButtons
        agreeButton.applyGradient(colours: [R.color.darkGreen()!, R.color.lightGreen()!])
    }

}


// MARK: - Action Methods

extension ZATermsAndConditionsViewController {
    
    @IBAction private func agreeButtonTapped(_ sender: UIButton) {
        let navController = R.storyboard.main.instantiateInitialViewController()!
        view.window?.swapRoot(viewController: navController, animation: .push)
    }
    
    @IBAction private func declineButtonTapped(_ sender: UIButton) {
        ZAUserDefaults.user.clear()
        Logger.shared.log(message: "Decline Policy", type: .warn)
        let authNavController = R.storyboard.authentication.instantiateInitialViewController()!
        self.view.window?.swapRoot(viewController: authNavController, animation: .dismiss)
    }
}
