//
//  SceneDelegate.swift
//  SOPT_Week1_UI
//
//  Created by 정정욱 on 10/5/24.
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
        let navigationController = UINavigationController(rootViewController: ViewController())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // 씬이 연결 해제될 때
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // 씬이 활성 상태가 될 때
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // 씬이 비활성 상태로 전환될 때
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // 씬이 포어그라운드로 전환될 때
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // 씬이 백그라운드로 전환될 때
    }
    
    
}

