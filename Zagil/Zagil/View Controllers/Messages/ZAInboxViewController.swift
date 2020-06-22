//
//  ZAInboxViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 20/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ZAInboxViewController: ZAViewController {

    
    // MARK: - Class Properties
    
    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Inbox"
    }
    
    private func setupViewController() {
        addUnderDevelopmentLabel()
    }

}
