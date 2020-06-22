//
//  ZAAuthenticationViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ZAAuthenticationViewController: ZAViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var createAccountButton: ZAButton!
    @IBOutlet private weak var signInButton: ZAButton!
    
    
    // MARK: - Life - Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupViewController() {
        createAccountButton.isGradient = true
    }
    
}


// MARK: - Action Methods

extension ZAAuthenticationViewController {
    
    @IBAction private func createAccountButtonTapped(_ sender: ZAButton) {
        present(viewController: ZASignUpViewController.self, storyboard: R.storyboard.authentication()) { signupVC in
            signupVC.modalPresentationStyle = .overFullScreen
        }
    }
    
    @IBAction private func signInButtonTapped(_ sender: ZAButton) {
        present(viewController: ZALoginViewController.self, storyboard: R.storyboard.authentication()) { signupVC in
            signupVC.modalPresentationStyle = .overFullScreen
        }
    }
    
}
