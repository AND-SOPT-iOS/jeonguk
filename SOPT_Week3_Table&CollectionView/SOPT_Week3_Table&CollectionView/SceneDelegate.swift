//
//  SceneDelegate.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/30/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // Create the main view controller
        let mainViewController = MainViewController()
        
        // Wrap the main view controller in a navigation controller
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        // Set the navigation controller as the root view controller
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}


