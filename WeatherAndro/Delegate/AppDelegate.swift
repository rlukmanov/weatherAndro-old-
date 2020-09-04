//
//  AppDelegate.swift
//  Weather App
//
//  Created by Ruslan Lukmanov on 20.07.2020.
//  Copyright © 2020 Ruslan Lukmanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: PageViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

