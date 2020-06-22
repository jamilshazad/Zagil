//
//  ZANavigationController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ZANavigationController: UINavigationController {

    
    // MARK: - Life - Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white, .font : UIFont.bold(fontSize: 20, font: .ooredoo)]
        navigationBar.tintColor = .white
        navigationBar.prefersLargeTitles = false
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        addGradientToNavigationBar(colors: [R.color.darkGreen()!, R.color.lightGreen()!])
    }

}
