//
//  ZAViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import MBProgressHUD
import LBTATools

class ZAViewController: UIViewController {

    
    // MARK: - Class Properties
    
    @IBInspectable var endEditingOnTouch: Bool = true
    typealias VCConfigurator<T> = (T) -> Void
    public var barStyle: UIBarStyle? {
        get {
            return navigationController?.navigationBar.barStyle
        }
        set {
            navigationController?.navigationBar.barStyle = newValue ?? .black
        }
    }

    
    // MARK: - Life - Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        customizeBackButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if let tabBarController = tabBarController as? ZATabBarViewController {
//            hidesBottomBarWhenPushed ? tabBarController.hideDashboardButton() : tabBarController.showDashboardButton()
//        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let tabBarController = tabBarController as? ZATabBarViewController {
                 hidesBottomBarWhenPushed ? tabBarController.hideDashboardButton() : tabBarController.showDashboardButton()
             }
    }
    
    // MARK: - UIResponder
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if endEditingOnTouch {
            view.endEditing(true)
        }
    }

    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        let backImage = R.image.back()
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func customizeBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        let yourBackImage = R.image.back()
        navigationController?.navigationBar.backIndicatorImage = yourBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }
    
    
    // MARK: - Public Methods
    
    public func instanceFromStoryboard<T: UIViewController>(storyboard: UIStoryboard) -> T {
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    public func push<T: UIViewController>(viewController: T.Type,
                                          storyboard: UIStoryboard,
                                          configure: VCConfigurator<T>? = nil) {
        let viewController: T = instanceFromStoryboard(storyboard: storyboard)
        configure?(viewController)
        if let tabBarController = tabBarController as? ZATabBarViewController {
            tabBarController.hideDashboardButton()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func present<T: UIViewController>(viewController: T.Type,
                                             storyboard: UIStoryboard,
                                             configure: VCConfigurator<T>? = nil) {
        let viewController: T = instanceFromStoryboard(storyboard: storyboard)
        configure?(viewController)
        present(viewController, animated: true, completion: nil)
    }
    
    public func showHud() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    public func hideHud() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    public func showAlert(_ title: String = "Zagil", message: String, completion: EmptyCompletion? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let _ = self else { return }
            completion?()
        }
        alertController.addAction(actionOK)
        alertController.preferredAction = actionOK
        present(alertController, animated: true, completion: nil)
    }
    
    public func checkIfUserIsLogin()-> Bool{
      let userInfo = ZAUserDefaults.user.get()
        if userInfo == nil {
            showAlert(message: "Please login first to proceed.")
            return false
        }
        return true
    }
    
    public func addUnderDevelopmentLabel() {
        let label = UILabel(text: "UNDER DEVELOPMENT",
                            font: UIFont.bold(fontSize: 25),
                            textColor: R.color.lightGrey()!,
                            textAlignment: .center,
                            numberOfLines: 0)
        view.addSubview(label)
        label.centerXToSuperview()
        label.centerYToSuperview()
        label.constrainWidth(view.width * 0.8)
    }
    
    public func displayService(error: Error) {
        var message = error.localizedDescription
        if let err = error as? ServiceError {
            message = err.errorDescription ?? ""
        }
        showAlert(message: message)
    }
    
}
