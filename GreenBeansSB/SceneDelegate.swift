//
//  SceneDelegate.swift
//  GreenBeansSB
//
//  Created by Blake Wisniewski on 12/11/1399 AP.
//

import UIKit
import Firebase
import FirebaseCore
import CoreLocation
import PushKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    var authListener: AuthStateDidChangeListenerHandle?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToStore), name: NSNotification.Name(rawValue: "autoLoggedIn"), object: nil)
        
        //AutoLogin
        if Auth.auth().currentUser != nil {
          // User is signed in.
            self.goToStore()
        } else {
          // No user is signed in.
            self.goToLogin()
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func goToLogin() {
        let loginVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
        loginVC.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = loginVC
    }
    
    @objc func goToStore() {
        let virtualStoreVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VirtualStore") as! VirtualStoreViewController
        virtualStoreVC.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = virtualStoreVC
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

