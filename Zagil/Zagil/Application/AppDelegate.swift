//
//  AppDelegate.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import GooglePlaces
import DropDown

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup Google SDK
        GIDSignIn.sharedInstance().clientID = ConfigurationManager.value(for: .googleClientID)
        GMSPlacesClient.provideAPIKey(ConfigurationManager.value(for: .googleApiKey))
        
        // Setup Facebook SDK
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Setup DropDown
        DropDown.startListeningToKeyboard()
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let facebook = ApplicationDelegate.shared.application(app, open: url,
                                                                     sourceApplication: options[.sourceApplication] as? String,
                                                                     annotation: options[.annotation])
        let google = GIDSignIn.sharedInstance().handle(url)
        return facebook || google
    }
    
}


// MARK: - Private Methods

extension AppDelegate {
    
    private func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        if let _ = ZAUserDefaults.user.get() {
            let navController = R.storyboard.main.instantiateInitialViewController()!
            window?.swapRoot(viewController: navController, animation: .push)
        } else {
            window?.rootViewController = R.storyboard.authentication.instantiateInitialViewController()
        }
        
        window?.makeKeyAndVisible()
    }
    
}

