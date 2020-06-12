//
//  AppDelegate.swift
//  inventoryApp
//
//  Created by Kaya Click on 5/20/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import UIKit

struct staticVars {
    let versionNum          = "V0.0.1"
    var backgroundColour    = #colorLiteral(red: 0.2662798464, green: 0.3903673589, blue: 0.5146622658, alpha: 1)
    var foreGroundColor     = #colorLiteral(red: 0.7098039216, green: 0.3960784314, blue: 0.462745098, alpha: 1)
    var textColour          = #colorLiteral(red: 0.9176470588, green: 0.6745098039, blue: 0.5450980392, alpha: 1)
    var accentColour        = #colorLiteral(red: 0.8980392157, green: 0.4196078431, blue: 0.4352941176, alpha: 1)
    var accentColourTwo     = #colorLiteral(red: 0.4274509804, green: 0.3490196078, blue: 0.4784313725, alpha: 1)
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //TODO add styles to toasts
    //Add colour scheme option

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().backgroundColor = staticVars().accentColour
        UINavigationBar.appearance().barTintColor = staticVars().accentColour
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = staticVars().accentColourTwo
        //let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        //statusBar?.backgroundColor = staticVars().accentColour
        
        return true
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

