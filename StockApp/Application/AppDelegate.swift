//
//  AppDelegate.swift
//  StockApp
//
//  Created by Рауан Абишев on 24.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame:  UIScreen.main.bounds)
        window.rootViewController = LaunchScreenViewController()
        window.makeKeyAndVisible()
        
        
        self.window = window
        return true
    }

    


}

