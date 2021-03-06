//
//  AppDelegate.swift
//  JBus
//
//  Created by William Thomas on 2/7/19.
//  Copyright © 2019 William Thomas. All rights reserved.
//

import UIKit
import GoogleMaps

import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    let center = UNUserNotificationCenter.current()
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCLG_ubR0Aoa9gv2uWw7l9jEUXgJsriuZc")
        
        //        GMSPlace.provideAPIKey("AIzaSyCLG_ubR0Aoa9gv2uWw7l9jEUXgJsriuZc")
        // Override point for customization after application launch.
       
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        }
        
        return true
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if segue.destination is MapViewController
//        {
//            let vc = segue.destination as? MapViewController
//            print(lastLocation, "1234")
//            vc?.location = lastLocation
//        }
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user qufits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


