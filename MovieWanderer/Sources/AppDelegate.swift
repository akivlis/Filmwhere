//
//  AppDelegate.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 05/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupFirebase()
        setupTabBarController()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
            if (rootViewController.responds(to: #selector(PictureViewController.canRotate))) {
                // Unlock landscape view orientations for this view controller
                return .allButUpsideDown
            }
            
            if ((rootViewController as? TakePhotoViewController) != nil) {
                return .landscapeRight
            }
        }
        // Only allow portrait (standard behaviour)
        return .portrait
    }
}

private extension AppDelegate {
    
    private func setupFirebase() {
        FirebaseApp.configure()
    }
    
    private func setupTabBarController() {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let tabBarViewController = MainTabBarController()
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor = .brightPink
    }
    
    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if (rootViewController == nil) { return nil }
        if (rootViewController.isKind(of: UITabBarController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController.isKind(of: UINavigationController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        } else if (rootViewController.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }
}

