//
//  AppDelegate.swift
//  wgs
//
//  Created by 08APO0516 on 06/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        StartUpAppSequencer.shared.start()
        return true
    }
}

