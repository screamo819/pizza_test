//
//  AppDelegate.swift
//  PIZZA_TEST
//
//  Created by Evgeny on 04.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var main: Main?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeRoot()
        return true
    }
}

// MARK: Private
private extension AppDelegate {
    func initializeRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
        
        main = Main(window)
        main?.router.start()
    }
}


