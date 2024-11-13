//
//  SceneDelegate.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let keyChainManager = DefaultKeyChainManager()
        let apiService = APIService(keyChainManager: keyChainManager)
        let rootViewController = LoginViewController(
            apiService: apiService,
            keyChainManager: keyChainManager
        )
        let navigationController = UINavigationController(
            rootViewController: rootViewController
        )
        navigationController.isNavigationBarHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}


