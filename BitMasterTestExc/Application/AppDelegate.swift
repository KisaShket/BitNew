//
//  AppDelegate.swift
//  BitMasterTestExc
//
//  Created by Kisa Shket on 29.03.2021.
//

import UIKit
import GoogleMaps
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(Constants.kGMSAPIkey)
        return true
    }
}

