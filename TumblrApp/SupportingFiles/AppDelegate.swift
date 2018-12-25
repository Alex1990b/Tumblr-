//
//  AppDelegate.swift
//  TumblrApp
//
//  Created by Sasha on 21.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureAppAppearance()
        initiateFirstViewController()

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if url.host == "oauth-callback" {
            OAuthService.handle(url: url)
        }
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataService.shared.saveContext()
    }
}

private extension AppDelegate {
    func configureAppAppearance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        barButtonItemAppearance.tintColor = .white
    }
    
    func initiateFirstViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UserDefaults.standard.oauthToken != nil ? UIStoryboard.getStoryboard(by: .menu) : UIStoryboard.getStoryboard(by: .auth)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

