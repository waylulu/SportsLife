//
//  AppDelegate.swift
//  SportsLife
//
//  Created by WTW on 2018/6/20.
//  Copyright © 2018年 west. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        
//        self.window = UIWindow.init(frame: UIScreen.main.bounds)
//        self.window?.backgroundColor = UIColor.white
//        self.window?.makeKeyAndVisible()
//        self.window?.rootViewController = RootTabBarViewController()
//        
//        return true
//    }

    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = RootTabBarViewController()
    }
    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
 
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

