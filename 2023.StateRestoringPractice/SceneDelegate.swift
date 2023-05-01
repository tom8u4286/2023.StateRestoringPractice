//
//  SceneDelegate.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆 on 2023/4/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // 主要頁面
    var main: MainTabsController!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        main = MainTabsController()
        window?.rootViewController = main
        window?.makeKeyAndVisible()
        
        /// 上一次關閉App時所保存的userActivity，可以在本次開啟App時，從session.stateRestorationActivity取得。
        ///
        /// -Authors: Tomtom Chu
        /// -Date: 2023.5.1
        guard let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity else { return }
        
        /// 確認這個被讀取出來的userActivity，是不是符合我們AppBundle所設定的UserActivity Type。
        /// 如果是，我們就將他Assign給當前Scene的userActivity。
        /// scene.userActivity將在下一次App關閉時被保存。
        ///
        /// -Authors: Tomtom Chu
        /// -Date: 2023.5.1
        if configure(window: window, with: userActivity) {
            // Remember this activity for later when this app quits or suspends.
            scene.userActivity = userActivity
        } else {
            Swift.debugPrint("Failed to restore scene from \(userActivity)")
        }
        
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

        // Save changes in the application's managed object context when the application transitions to the background.
    }
    
    // MARK: - 狀態保存相關 State Restoration
    
    /// 由於userInfo是以Key-Value的方式除存資料，
    /// 這參考Apple官方範例，設計一個Key (.selectedTabKey) 來儲存被點選到的分頁(Tab)。
    /// 在官方範例中，還設計了其他的Key來儲存不同資料。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.5.1
    static let selectedTabKey = "selectedTab"
    
    /// ⭐️ 重要：
    /// 實作這個function，在App關閉時，告訴系統要被儲存的userActivity。
    /// 下次App開啟App時，willConnectTo的session.stateRestorationActivity將會取得這個userActivity。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.5.1
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return scene.userActivity
    }
    
    /// 從App Bundle(Info.plist)中讀取Activity Type。
    /// 在Scene-Based(UserActivity-based)的狀態保存設計中，必須要在plist中設定Activity type。
    /// 可參考：https://developer.apple.com/documentation/foundation/nsuseractivity
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.5.1
    static let MainSceneActivityType = { () -> String in
        let activityTypes = Bundle.main.infoDictionary?["NSUserActivityTypes"] as? [String]
        return activityTypes![0]
    }
    
    /// 這個function確認App開啟後，被讀取出來的userActivity是否符合App Bundle(Info.plist)中設定的UserActivity Type，
    /// 若符合，則將這個userActivity的內容取出來使用。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.5.1
    func configure(window: UIWindow?, with activity: NSUserActivity) -> Bool {
        var succeeded = false
        
        if activity.activityType == SceneDelegate.MainSceneActivityType() {
            // 開始從UserActivity中的userInfo取出資料：上次離開時的Tab頁面。
            if let userInfo = activity.userInfo {
                // 從userActivity中的userInfo取得上次停留的Tab
                if let selectedTab = userInfo[SceneDelegate.selectedTabKey] as? Int {
                    main.restoredSelectedTab = selectedTab
                }
                succeeded = true
            }
        } else {
            // The incoming userActivity is not recognizable here.
        }
        
        return succeeded
    }


}


