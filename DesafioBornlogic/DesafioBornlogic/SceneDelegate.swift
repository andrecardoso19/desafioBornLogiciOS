//
//  SceneDelegate.swift
//  DesafioBornlogic
//
//  Created by André Cardoso Aragão on 14/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UINavigationController(rootViewController: HomeViewController())
            self.window = window
            window.makeKeyAndVisible()
            
        }
    }
}

