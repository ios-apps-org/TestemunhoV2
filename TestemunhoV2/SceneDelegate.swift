//
//  SceneDelegate.swift
//  TestemunhoV2
//
//  Created by Jon DeMaagd on 8/27/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        print("")
        print("didFinishLaunchingWithOptions??")
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        print("")
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("")
        print("sceneDidBecomeActive")
        print("applicationDidBecomeActive")
        print("")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("")
        print("sceneWillResignActive")
        print("when something happens to phone while app is open (foreground)")
        print("i.e. user receives a call: place to keep user from losing data")
        print("i.e. filling out form and get a call in process w/o finishing form")
        print("applicationWillResignActive")
        print("")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("")
        print("sceneWillEnterForeground")
        print("applicationWillEnterForeground")
        print("")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("")
        print("sceneDidEnterBackground")
        print("app disappears off screen, enters background")
        print("i.e. press home or open different app")
        print("applicationDidEnterBackground")
        print("")
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
