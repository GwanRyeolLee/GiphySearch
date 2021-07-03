//
//  AppDelegate.swift
//  GiphySearch
//
//  Created by 이관렬 on 2021/07/01.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        let vc = SearchViewController.loadFromNib()
        let navi = UINavigationController(rootViewController: vc)
        window.rootViewController = navi
        
        self.window = window
        
        return true
    }
}

