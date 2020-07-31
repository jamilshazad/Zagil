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
import Firebase
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup Google SDK
        GIDSignIn.sharedInstance().clientID = ConfigurationManager.value(for: .googleClientID)
        GMSPlacesClient.provideAPIKey(ConfigurationManager.value(for: .googleApiKey))
        
        // Setup Facebook SDK
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        setupRootViewController()
        // Setup DropDown
        DropDown.startListeningToKeyboard()
        
        //configuring firebase
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let facebook = ApplicationDelegate.shared.application(app, open: url,
                                                                     sourceApplication: options[.sourceApplication] as? String,
                                                                     annotation: options[.annotation])
        let google = GIDSignIn.sharedInstance().handle(url)
        return facebook || google
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

      let dataDict:[String: String] = ["token": fcmToken]
        ZAUserDefaults.token.set(value: fcmToken)
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
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

