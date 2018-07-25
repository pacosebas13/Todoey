//
//  AppDelegate.swift
//  Todoey
//
//  Created by Paco Sebastián Rebollar on 15/7/18.
//  Copyright © 2018 Paco Sebastián Rebollar. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        do {
            let _ = try Realm()
        } catch {
            print("Error with Realm")
        }
        
        return true
    }



}

