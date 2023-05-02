//
//  AppDelegate.swift
//  HSL.V2
//
//  Created by Yana Krylova on 26.4.2023.
//

import Foundation

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let userDefaults = UserDefaults.standard
        let isFirstLaunch = userDefaults.bool(forKey: WelcomeScreenModel.isFirstLaunchKey)
        var selectedRole = ""
        
        if !isFirstLaunch {
            // If this is the first launch, set the value of isFirstLaunch to true
            userDefaults.set(true, forKey: WelcomeScreenModel.isFirstLaunchKey)
            userDefaults.synchronize()
            
            // Show the welcome screen view
            let welcomeScreenModel = WelcomeScreenModel()
            let welcomeScreenView = WelcomeScreenView()
            window?.rootViewController = welcomeScreenView
        } else {
            // Show the home screen view
            let homeView = HomeView(selectedRole: selectedRole)
            window?.rootViewController = homeView
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

