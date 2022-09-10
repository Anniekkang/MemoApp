//
//  SceneDelegate.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let _ = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: scene)
        
//        UserDefaults.standard.set(true, forKey: "firstPopup")
//        let firstPopup = UserDefaults.standard.bool(forKey: "firstPopup")
//
//        if !firstPopup {
//            let alert = UIAlertController(title: nil, message: "처음 오셨군요! \n 환영합니다 :) \n\n 당신만의 메모를 작성하고 \n 관리해보세요!", preferredStyle: .alert)
//
//            let ok = UIAlertAction(title: "확인", style: .default)
//            alert.addAction(ok)
//            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//
//
//        } else {
//            self.window?.rootViewController?.present(MainViewController(), animated: true)
//        }
//
//        window?.makeKeyAndVisible()
//
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

