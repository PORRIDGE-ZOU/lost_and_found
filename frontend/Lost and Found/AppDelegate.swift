//
//  AppDelegate.swift
//  Lost and Found
//
//  Created by Haoxuan Zou on 11/20/21.
//

import UIKit
let userData = UserDefaults.standard;
let encoder = JSONEncoder();
let decoder = JSONDecoder();
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // For Back button customization, setup the custom image for UINavigationBar inside CustomBackButtonNavController.
        print("settingbakcbutton..")
        let backButtonBackgroundImage = UIImage(named: "backbutton")
        let barAppearance =
        UINavigationBar.appearance(whenContainedInInstancesOf: [FoundViewController.self])
        barAppearance.backIndicatorImage = backButtonBackgroundImage
        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        // Nudge the back UIBarButtonItem image down a bit.
        let barButtonAppearance =
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [FoundViewController.self])
        barButtonAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -5), for: .default)
    
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

