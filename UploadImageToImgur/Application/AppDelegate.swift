//
//  AppDelegate.swift
//  
//
//  Created by Vitalii Derhunov on 8/8/19.
//
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: PhotoGridViewController())
        NetworkReachabilityManager.shared.beginReachability()
        return true
    }
}
