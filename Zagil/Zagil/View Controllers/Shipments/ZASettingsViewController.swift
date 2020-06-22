//
//  ZASettingsViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 28/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

enum SettingItem: Int {
    case notification
    case privacy
    case invite
    case feedbackAndSupport
    case privacyPolicy
    case termsAndConditions
    case signOut
    case follow
}

class ZASettingsViewController: ZATableViewController {

    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Settings & Setup"
    }
    
    private func manageNotification() {
        
    }
    
    private func privacy() {
        
    }
    
    private func invite() {
        let items = [R.string.localizable.shareMessage()]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func feedback() {
        
    }
    
    private func privacyPolicy() {
        
    }
    
    private func termsAndCondition() {
        push(viewController: ZATermsAndConditionsViewController.self, storyboard: R.storyboard.privacy()) { [weak self] termsAndConditionVC in
            guard let _ = self else { return }
            termsAndConditionVC.hidesBottomBarWhenPushed = true
            termsAndConditionVC.hideButtons = true
        }
    }
    
    private func signOut() {
        let alertController = UIAlertController(title: R.string.localizable.signoutTitle(), message: R.string.localizable.signoutMessage(), preferredStyle: .alert)
                
        let signoutAction = UIAlertAction(title: R.string.localizable.signout(), style: .default) { [weak self] _ in
            guard let self = self else { return }
            ZAUserDefaults.user.clear()
            let authNavController = R.storyboard.authentication.instantiateInitialViewController()!
            self.view.window?.swapRoot(viewController: authNavController, animation: .dismiss)
        }

        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil)

        alertController.addAction(signoutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func follow() {
        
    }

}


// MARK: - Table View Methods

extension ZASettingsViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = SettingItem(rawValue: indexPath.section) {
            switch item {
            case .notification: manageNotification()
            case .privacy: privacy()
            case .invite: invite()
            case .feedbackAndSupport: feedback()
            case .privacyPolicy: privacyPolicy()
            case .termsAndConditions: termsAndCondition()
            case .signOut: signOut()
            case .follow: follow()
            }
        }
    }
    
}
