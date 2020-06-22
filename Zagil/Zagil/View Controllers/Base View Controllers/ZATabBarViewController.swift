//
//  ZATabBarViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 20/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ZATabBarViewController: UITabBarController {

    
    // MARK: - Class Properties
    
    private var dashboardButton: UIButton!
    
    
    // MARK: - Life - Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupTabbar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Private Methods
    
    private func setupTabbar() {
        tabBar.tintColor = R.color.lightGreen()
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        addCenterButton()
        
        selectedIndex = 2
    }
    

    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    private func addCenterButton() {
        
        let yAxisOfButton = hasTopNotch ? tabBar.y - 20 : tabBar.y + 5
        
        dashboardButton = UIButton(type: .custom)
        dashboardButton.frame.size = CGSize(width: 70, height: 70)
        dashboardButton.setTitle("", for: .normal)
        dashboardButton.setTitle("", for: .highlighted)
        dashboardButton.setImage(R.image.dashboard(), for: .normal)
        dashboardButton.setImage(R.image.dashboard(), for: .highlighted)
        
        dashboardButton.center = CGPoint(x: tabBar.center.x, y: yAxisOfButton  )


        dashboardButton.addTarget(self, action: #selector(dashboardButtonTapped(_:)), for: .touchUpInside)

        view.addSubview(dashboardButton)
        self.view.bringSubviewToFront(dashboardButton)

    }
//
    
    // MARK: - Public Methods
    
    public func hideDashboardButton() {
        dashboardButton.isHidden = true
    }
    
    public func showDashboardButton() {
        self.dashboardButton.isHidden = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) { [weak self] in
            guard let self = self else { return }
            self.view.bringSubviewToFront(self.dashboardButton)
        }
    }

}


// MARK: - Action Methods

extension ZATabBarViewController {
    
    @objc
    private func dashboardButtonTapped(_ sender: UIButton) {
        selectedIndex = 2
    }
    
}
