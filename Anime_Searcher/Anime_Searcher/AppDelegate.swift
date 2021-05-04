//
//  AppDelegate.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 29/04/21.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        //window!.rootViewController = UIStoryboard.buildTableViewController()
        window!.makeKeyAndVisible()
    }


}
