//
//  AppDelegate.swift
//  UseePayDemo
//
//  Created by Mingwei Shi on 2025/4/12.
//

import UIKit
import UseePayCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureUseePaySDK()
        return true
    }
    
    private func configureUseePaySDK() {
        // Read configuration from secure storage
        let env: UseePayCore.UPNetworkingEnv = .production  // or .sandbox for sandbox environment
        let merchantNo = "Your merchant number"
        
        do {
            try UseePay.setup(
                env: env,
                merchantNo: merchantNo
            )
        } catch {
            print("UseePay initialization failed: \(error.localizedDescription)")
        }
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

