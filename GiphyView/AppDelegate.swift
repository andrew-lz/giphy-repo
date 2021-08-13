//
//  AppDelegate.swift
//  GiphyView
//
//  Created by BMF on 15.07.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController(collectionViewLayout: CollectionViewLayout())
        window?.makeKeyAndVisible()
        return true
    }
    
}
