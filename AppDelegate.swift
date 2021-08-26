//
//  AppDelegate.swift
//  GiphyView
//
//  Created by BMF on 20.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let view = ViewController(collectionViewLayout: CollectionViewLayout())
        let imageDataPresenter = TrandResponsePresenter(view: view)
        imageDataPresenter.didStart()
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        return true
    }
}
