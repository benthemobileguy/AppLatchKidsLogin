//
//  SceneDelegate.swift
//  ApplatchKidsLogin
//
//  Created by apple on 1/7/25.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create window with frame
        let window = UIWindow(windowScene: windowScene)
        
        // Create and set root view controller
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        // Set window's root view controller and make it visible
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // Assign window to scene delegate's window property
        self.window = window
    }
}

