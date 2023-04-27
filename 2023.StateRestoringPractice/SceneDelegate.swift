//
//  SceneDelegate.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆 on 2023/4/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
            
        let window = UIWindow(windowScene: windowScene)
        
        
//        print(session.stateRestorationActivity)
        
//        guard let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity else { return }
        
        print("SceneDelegate: connectionOptions.userActivities.first: \(connectionOptions.userActivities.first)")
        print("SceneDelegate: scene.session.stateRestorationActivity: \(scene.session.stateRestorationActivity)")
        
        
        if let userActivity = connectionOptions.userActivities.first ?? scene.session.stateRestorationActivity {
                // Restore the user interface from the state restoration activity.
//            setupScene(with userActivity: userActivity)
            
            print("SceneDelegate：userActivity有值！")
        }
        
        window.rootViewController = ViewController() // Where ViewController() is the initial View Controller
        window.makeKeyAndVisible()
        self.window = window
        
//        if configure(window: window, session: session, with: userActivity) {
//            print("🍎 SceneDelegate: configure()")
//            // Remember this activity for later when this app quits or suspends.
//            scene.userActivity = userActivity
//
//            /** Set the title for this scene to allow the system to differentiate multiple scenes for the user.
//                If set to nil or an empty string, the system doesn't display a title.
//            */
//            scene.title = userActivity.title
//
//            // Mark this scene's session with this userActivity product identifier so you can update the UI later.
//            if let sessionProduct = SceneDelegate.product(for: userActivity) {
//                /// userInfo是一個以Key-Value的儲存資料的變數。
//                ///
//                /// NSUserActivity與UISceneSession都有userInfo，可以儲存資訊。
//                /// 在SceneDelegate+StateRestoration.swift檔案中，有宣告幾種key值。SceneDelegate.productIdentifierKey是其中一種。
//                ///
//                /// -Authors: Tomtom Chu
//                /// -Date: 2023.4.25
////                session.userInfo = [SceneDelegate.productIdentifierKey: sessionProduct.identifier]
//            }
//        } else {
//            Swift.debugPrint("Failed to restore scene from \(userActivity)")
//        }
        
        
    }
    
    func configure(window: UIWindow?, session: UISceneSession, with activity: NSUserActivity) -> Bool {
        var succeeded = false
        
        if activity.activityType == SceneDelegate.MainSceneActivityType() {
            
            let presentView = ViewController()
            
            if let userInfo = activity.userInfo {
                
                if let navigationController = window?.rootViewController as? UINavigationController {
                    // 進入presentView
                    navigationController.pushViewController(presentView, animated: false)
                }
                
                
                succeeded = true
                
            }
            
        }
        
        return succeeded
    }
    
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        if let userActivity = window?.windowScene?.userActivity {
            userActivity.becomeCurrent()
        }
    }

    
    func sceneWillResignActive(_ scene: UIScene) {
        // Save any pending changes to the product list.
//        DataModelManager.sharedInstance.saveDataModel()
        
        print("🇰🇵 SceneDelegate: sceneWillResignActive()")
        
        if let userActivity = window?.windowScene?.userActivity {
            userActivity.resignCurrent()
            
            scene.userActivity = userActivity
        }
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
    // MARK: - Handoff support
    
    func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        //..
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        
        print("🇹🇷 SceneDelegate: continue")
        
        guard userActivity.activityType == SceneDelegate.MainSceneActivityType() else { return }
 
//        if let rootViewController = window?.rootViewController as? UINavigationController {
//            // Update the detail view controller.
//            if let detailParentViewController = rootViewController.topViewController as? DetailParentViewController {
//                detailParentViewController.product = SceneDelegate.product(for: userActivity)
//            }
//        }
    }

    func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        
        print("🇯🇵 SceneDelegate: didFailToContinueUserActivityWithType")
        
        let alert = UIAlertController(title: NSLocalizedString("UnableToContinueTitle", comment: ""),
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OKTitle", comment: ""), style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        print("🇮🇸 SceneDelegate: stateRestorationActivity() userActivity:\(scene.userActivity)")
        return scene.userActivity
    }

}

