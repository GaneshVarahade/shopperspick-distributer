//
//  AppDelegate.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 18/05/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Fabric
//import Crashlytics
public let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        } 
        
        // MARK: - KeyBord Manager
        IQKeyboardManager.shared.enable = true
        
        // MARK: - Network Rechability Cheking in Real time
        ReachabilityManager.shared.startMonitoring()
        
        //Crashlytics().debugMode = true
        //Fabric.with([Crashlytics.self])
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        for window in application.windows {
            window.rootViewController?.beginAppearanceTransition(true, animated: false)
            window.rootViewController?.endAppearanceTransition()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
    }

    // MARK: - Core Data stack


}

