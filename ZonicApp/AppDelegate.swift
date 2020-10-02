//
//  AppDelegate.swift
//  ZonicApp
//
//  Created by MagdielG on 4/15/20.
//  Copyright © 2020 Magdiel Gómez. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = HomeController()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

   


}

