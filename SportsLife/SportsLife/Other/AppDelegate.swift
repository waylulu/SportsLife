//
//  AppDelegate.swift
//  SportsLife
//
//  Created by WTW on 2018/6/20.
//  Copyright © 2018年 west. All rights reserved.
//

import UIKit
import GoogleMobileAds


@objcMembers
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UNUserNotificationCenterDelegate{

    var window: UIWindow?


//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        HTLanguageHelper.shard.initLanguage()
//        self.initCloudPush()
//        self.registerAPNs(application)
//
//        self.window = UIWindow.init(frame: UIScreen.main.bounds)
//        self.window?.backgroundColor = UIColor.white
//        self.window?.makeKeyAndVisible()
//        self.window?.rootViewController = RootTabBarViewController()
//
//
//        return true
//    }

    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        
        HTLanguageHelper.shard.initLanguage()
        
        self.initCloudPush()
        self.registerAPNs(application)
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = RootTabBarViewController()
        #if DEBUG

//        Bundle.init(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load();

        #endif

//        AlertView.shard.alertDetail(controller: (self.window?.rootViewController!)!, title: "该版本已不支持请前往App Store更新") {
//        }

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


    
    func initCloudPush(){
        
        CloudPushSDK.asyncInit("25062079", appSecret: "4afc0d449c5c4e82e232da9131058890") { (result) in
            if result!.success{
                print("deviceId====\(CloudPushSDK.getDeviceId()!)")//cdd20acd33844cd593373dc989c625ad
            }else{
                print((result?.error)!)
            }
        }
    }
    
    
    func registerAPNs(_ application:UIApplication){

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        let type = UNAuthorizationOptions.init(arrayLiteral: [.alert,.badge,.sound])
        notificationCenter.requestAuthorization(options: type) { (isPush, err) in
            if isPush{
                print("success")
            }else{
                print(err)
            }
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("deviceToken====\(deviceToken.hexString)")//64f82195635e2901a2a3e520a8f0589e936117990fcb25529ce906e3b1d4bf4d//3f2e470a1c44847a0abf3f058ea1a514406e9f43fe54349a6e9fd997222dc8a4/3b91b14a02cf52ef86a122815b1c76058f06ecd79da715d41fd5fb3c1cbac30a//f0b1b842138949fedc0ec08c20ab5d7f5c658022e97779acae56e69e3ebc2924

        UserDefaults.standard.set(deviceToken.hexString, forKey: "deviceToken");
          CloudPushSDK.registerDevice(deviceToken) { (res) in
                  if (res?.success)!{
                      print("success")
                  }else{
                      print(res?.error)
                  }
              }
        
        //        var deviceTokenString = String()
        //        let bytes = [UInt8](deviceToken)
        //        for item in bytes {
        //            deviceTokenString += String(format:"%02x", item&0x000000FF)
        //        }
                print("deviceTokendeviceTokenString====：\(deviceToken.deviceTokenString)")
                print("deviceTokenDataToString====：\(deviceTokenDataToString(deviceToken))")
    }
  
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
          print(error)
      }
      
      func registerMessageReceice() {
          NotificationCenter.default.addObserver(self, selector: #selector(onMessageNoti(noti:)), name: NSNotification.Name(rawValue: "CCPDidReceiveMessageNotification"), object: nil)
      }
    
    
    func onMessageNoti(noti:Notification){
        let message:CCPSysMessage = noti.object as! CCPSysMessage
        AlertView.shard.alertDetail(controller: (self.window?.viewController)!, title: message.title.hexString) {
            
        }
        print(message)
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
    }
}



